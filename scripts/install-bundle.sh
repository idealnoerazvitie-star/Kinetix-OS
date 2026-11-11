#!/usr/bin/env bash
set -eu

# Install an optional Quantix software bundle on Debian-based systems.
# Usage: ./scripts/install-bundle.sh [productivity|developer|maker|security-learning|gaming|accessibility]

BUNDLE="${1:-productivity}"

if ! command -v apt-get >/dev/null 2>&1; then
  echo "This script requires a Debian-based system with apt-get." >&2
  exit 1
fi

case "$BUNDLE" in
  productivity)
    PACKAGES=(firefox-esr thunderbird libreoffice-writer libreoffice-calc libreoffice-impress vlc okular gimp inkscape filezilla)
    ;;
  developer)
    PACKAGES=(git build-essential curl wget jq ripgrep fd-find htop vim neovim python3 python3-pip nodejs npm gdb)
    ;;
  maker)
    PACKAGES=(thonny python3-gpiozero arduino scratch)
    ;;
  security-learning)
    # Defensive system auditing and network visibility tools. Use only on systems
    # and networks you own or are explicitly authorized to assess.
    PACKAGES=(lynis clamav ufw wireshark tcpdump nmap)
    ;;
  gaming)
    PACKAGES=(lutris retroarch gamemode)
    ;;
  accessibility)
    PACKAGES=(orca onboard espeak-ng)
    ;;
  *)
    echo "Unknown bundle: $BUNDLE" >&2
    echo "Valid bundles: productivity, developer, maker, security-learning, gaming, accessibility" >&2
    exit 2
    ;;
esac

if [[ "${EUID}" -eq 0 ]]; then
  APT=(apt-get)
else
  if ! command -v sudo >/dev/null 2>&1; then
    echo "Please run as root or install sudo." >&2
    exit 1
  fi
  APT=(sudo apt-get)
fi

"${APT[@]}" update
"${APT[@]}" install -y --no-install-recommends "${PACKAGES[@]}"
printf '\nInstalled optional Quantix bundle: %s\n' "$BUNDLE"
