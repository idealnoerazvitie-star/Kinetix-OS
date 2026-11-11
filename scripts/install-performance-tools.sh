#!/usr/bin/env bash
set -euo pipefail

# Optional performance utilities for Quantix. No kernel, boot, governor, or
# service settings are changed automatically.

if ! command -v apt-get >/dev/null 2>&1; then
  echo "This script requires a Debian-based system with apt-get." >&2
  exit 1
fi

if [[ "${EUID}" -eq 0 ]]; then
  APT=(apt-get)
else
  if ! command -v sudo >/dev/null 2>&1; then
    echo "Run as root or install sudo." >&2
    exit 1
  fi
  APT=(sudo apt-get)
fi

"${APT[@]}" update
PACKAGES=()
for package in zram-tools tuned; do
  if apt-cache show "$package" >/dev/null 2>&1; then
    PACKAGES+=("$package")
  else
    echo "Skipping $package: not available in configured repositories."
  fi
done

if ((${#PACKAGES[@]} == 0)); then
  echo "No optional performance packages were found." >&2
  exit 1
fi

"${APT[@]}" install -y --no-install-recommends "${PACKAGES[@]}"
printf '\nInstalled available performance tools: %s\n' "${PACKAGES[*]}"
echo "Review package documentation and system settings before enabling tuning profiles."
