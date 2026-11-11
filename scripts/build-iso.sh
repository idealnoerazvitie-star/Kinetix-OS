#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
cd "$ROOT"

if [ "$(id -u)" -ne 0 ]; then
  if ! command -v sudo >/dev/null 2>&1; then
    echo "Run as root, or install sudo and run: sudo $0" >&2
    exit 1
  fi
  exec sudo "$0" "$@"
fi

if ! command -v lb >/dev/null 2>&1; then
  echo "live-build is required. On Debian: apt update && apt install live-build debootstrap xorriso squashfs-tools" >&2
  exit 1
fi

if [ ! -f /etc/debian_version ]; then
  echo "Build the Quantix ISO on Debian (or a Debian environment)." >&2
  exit 1
fi

# Use the checked-in live-build configuration, then build the hybrid ISO.
sh auto/config
lb build

printf '\nBuild complete. Look for the generated Quantix ISO in: %s\n' "$ROOT"
