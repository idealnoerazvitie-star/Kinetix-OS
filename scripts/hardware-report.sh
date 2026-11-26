#!/usr/bin/env bash
set -uo pipefail

OUT="${1:-/dev/stdout}"
if [[ "$OUT" != "/dev/stdout" ]]; then
  mkdir -p "$(dirname "$OUT")"
  : > "$OUT"
  exec > >(tee "$OUT") 2>&1
fi

section() {
  printf '\n===== %s =====\n' "$1"
}
run() {
  local label="$1"; shift
  section "$label"
  if command -v "$1" >/dev/null 2>&1; then
    local status=0
    "$@" 2>&1 | sed -E 's/([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}/[REDACTED-MAC]/g; s/^([[:space:]]*Serial Number:).*/\1 [REDACTED]/I' || status=$?
    if [[ "$status" -ne 0 ]]; then printf '[command exited with status %s]\n' "$status"; fi
  else
    printf '[not installed: %s]\n' "$1"
  fi
}

section "System"
date -Is
uname -srm
if [[ -r /etc/os-release ]]; then cat /etc/os-release; fi

run "PCI devices and drivers" lspci -nnk
run "USB devices" lsusb
run "Radio blocks" rfkill list
run "Network devices" nmcli device status
run "Bluetooth controllers" bluetoothctl list
run "PipeWire status" wpctl status
run "PulseAudio compatibility server" pactl info
run "ALSA playback devices" aplay -l
run "OpenGL renderer" glxinfo -B
run "Vulkan summary" vulkaninfo --summary
run "Firmware devices" fwupdmgr get-devices

section "Notes"
echo "This is a read-only inventory, not a hardware certification."
echo "Missing commands mean the diagnostic utility is not installed; they do not prove hardware is unsupported."
