#!/usr/bin/env bash
set -Eeuo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 path/to/kinetix.iso" >&2
  exit 2
fi

ISO="$(realpath "$1")"
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
if [[ ! -s "$ISO" ]]; then
  echo "ISO does not exist or is empty: $ISO" >&2
  exit 1
fi

for tool in xorriso qemu-system-x86_64 socat python3 tesseract; do
  command -v "$tool" >/dev/null 2>&1 || {
    echo "Required verification tool is missing: $tool" >&2
    exit 1
  }
done

WORK="$(mktemp -d)"
QEMU_PID=""
cleanup() {
  if [[ -f "$WORK/qemu.log" ]]; then cp "$WORK/qemu.log" dist/qemu.log 2>/dev/null || true; fi
  if [[ -f "$WORK/serial.log" ]]; then cp "$WORK/serial.log" dist/qemu-serial.log 2>/dev/null || true; fi
  if [[ -n "$QEMU_PID" ]] && kill -0 "$QEMU_PID" 2>/dev/null; then
    kill "$QEMU_PID" 2>/dev/null || true
    wait "$QEMU_PID" 2>/dev/null || true
  fi
  rm -rf "$WORK"
}
trap cleanup EXIT

mkdir -p dist
echo "Checking ISO filesystem and El Torito boot catalog..."
xorriso -indev "$ISO" -report_el_torito plain | tee dist/iso-boot-catalog.txt
grep -Eiq 'El Torito|Boot catalog' dist/iso-boot-catalog.txt || {
  echo "No El Torito boot catalog was reported." >&2
  exit 1
}

echo "Starting the ISO in QEMU (software emulation; no host KVM required)..."
qemu-system-x86_64 \
  -machine pc,accel=tcg \
  -cpu max \
  -m 4096 \
  -smp 2 \
  -cdrom "$ISO" \
  -boot order=d \
  -display none \
  -vga std \
  -monitor "unix:$WORK/monitor.sock,server,nowait" \
  -serial "file:$WORK/serial.log" \
  -no-reboot \
  -no-shutdown \
  -snapshot \
  >"$WORK/qemu.log" 2>&1 &
QEMU_PID=$!

for _ in $(seq 1 60); do
  [[ -S "$WORK/monitor.sock" ]] && break
  kill -0 "$QEMU_PID" 2>/dev/null || {
    cat "$WORK/qemu.log" >&2
    exit 1
  }
  sleep 1
done
[[ -S "$WORK/monitor.sock" ]] || {
  echo "QEMU monitor did not become ready." >&2
  cat "$WORK/qemu.log" >&2
  exit 1
}

# Give Debian Live time to boot, then switch to a text console for a stable
# machine-readable login prompt rather than relying on a graphical splash.
echo "Waiting up to 240 seconds for Debian Live to start..."
for _ in $(seq 1 24); do
  if ! kill -0 "$QEMU_PID" 2>/dev/null || [[ "$(ps -o stat= -p "$QEMU_PID" 2>/dev/null | tr -d ' ')" == Z* ]]; then
    echo "QEMU exited before the boot smoke test completed." >&2
    cat "$WORK/qemu.log" >&2
    cat "$WORK/serial.log" >&2 || true
    exit 1
  fi
  sleep 10
done

printf 'sendkey ctrl-alt-f2\n' | socat -t 2 - "UNIX-CONNECT:$WORK/monitor.sock" >/dev/null
sleep 5
printf 'screendump %s\n' "$WORK/boot.ppm" | socat -t 5 - "UNIX-CONNECT:$WORK/monitor.sock" >/dev/null
[[ -s "$WORK/boot.ppm" ]] || {
  echo "QEMU did not produce a boot screenshot." >&2
  cat "$WORK/qemu.log" >&2
  exit 1
}

python3 - "$WORK/boot.ppm" <<'PY'
from PIL import Image, ImageStat
import sys

image = Image.open(sys.argv[1]).convert("RGB")
if image.width < 640 or image.height < 400:
    raise SystemExit(f"Unexpected QEMU framebuffer size: {image.size}")
gray = image.convert("L")
if ImageStat.Stat(gray).stddev[0] < 4:
    raise SystemExit("QEMU framebuffer is effectively blank; boot was not verified.")
image.save("dist/qemu-boot-screen.png")
print(f"Captured non-blank QEMU framebuffer: {image.width}x{image.height}")
PY

tesseract dist/qemu-boot-screen.png dist/qemu-boot-screen >/dev/null 2>&1
if ! grep -Eiq 'login:|debian|trixie|kinetix' dist/qemu-boot-screen.txt; then
  echo "The QEMU screen did not contain a recognizable Debian/Kinetix login console." >&2
  cat dist/qemu-boot-screen.txt >&2 || true
  exit 1
fi

cp "$WORK/serial.log" dist/qemu-serial.log
cp "$WORK/qemu.log" dist/qemu.log
echo "QEMU boot smoke test passed: Debian/Kinetix login console detected."
