#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$ROOT"

if [ "$(id -u)" -ne 0 ]; then
  if ! command -v sudo >/dev/null 2>&1; then
    echo "Run as root, or install sudo and run: sudo $0" >&2
    exit 1
  fi
  exec sudo env KINETIX_ARCH="${KINETIX_ARCH:-amd64}" "$0" "$@"
fi

if [ ! -r /etc/debian_version ]; then
  echo "Kinetix ISO builds must run in Debian or a Debian-based build environment." >&2
  exit 1
fi

missing=""
for tool in lb debootstrap xorriso mksquashfs; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    missing="$missing $tool"
  fi
done
if [ -n "$missing" ]; then
  echo "Missing build tools:$missing" >&2
  echo "On Debian, install them with:" >&2
  echo "  sudo apt update && sudo apt install live-build debootstrap xorriso squashfs-tools" >&2
  exit 1
fi

if [ ! -f auto/config ] || [ ! -f config/package-lists/kinetix.list.chroot ]; then
  echo "Repository build configuration is incomplete; run this script from a complete Kinetix OS checkout." >&2
  exit 1
fi

ARCH="${KINETIX_ARCH:-amd64}"
case "$ARCH" in amd64|arm64) ;; *) echo "Unsupported KINETIX_ARCH: $ARCH (supported: amd64, arm64)." >&2; exit 2 ;; esac
export KINETIX_ARCH="$ARCH"
echo "Building Kinetix OS for architecture: $ARCH"

echo "Configuring Debian Live..."
sh auto/config

echo "Building Kinetix OS ISO (this can take a long time and use several GB of disk space)..."
lb build

printf '\nBuild complete. Check the repository directory for the generated Kinetix ISO.\n'
