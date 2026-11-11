#!/usr/bin/env bash
set -eu

# Quantix OS bundle installer
# Usage:
#   ./scripts/install-bundle.sh productivity
#   ./scripts/install-bundle.sh developer
#   ./scripts/install-bundle.sh all

BUNDLE="${1:-default}"

if ! command -v apt-get >/dev/null 2>&1; then
  echo "This script is intended for Debian-based systems."
  exit 1
fi

case "$BUNDLE" in
  productivity)
    PACKAGES=(
      firefox-esr thunderbird libreoffice-writer libreoffice-calc libreoffice-impress
      vlc okular gimp inkscape filezilla keepassxc
    )
    ;;
  developer)
    PACKAGES=(
      git build-essential curl wget jq ripgrep fd-find htop vim neovim python3 python3-pip
      nodejs npm docker.io docker-compose-plugin gdb
    )
    ;;
  maker)
    PACKAGES=(
      thonny python3-gpiozero arduino scratch gparted
    )
    ;;
  security-learning)
    PACKAGES=(
      nmap wireshark tcpdump aircrack-ng john hashcat binwalk gdb testdisk sqlmap
    )
    ;;
  gaming)
    PACKAGES=(
      steam lutris retroarch wine gamemode
    )
    ;;
  accessibility)
    PACKAGES=(
      orca onboard kdeaccessibility espeak-ng brltty
    )
    ;;
  all)
    PACKAGES=(
      firefox-esr thunderbird libreoffice-writer libreoffice-calc libreoffice-impress
      vlc okular gimp inkscape filezilla keepassxc git build-essential curl wget jq
      ripgrep fd-find htop vim neovim python3 python3-pip nodejs npm docker.io
      docker-compose-plugin gdb thonny python3-gpiozero arduino scratch gparted
      nmap wireshark tcpdump aircrack-ng john hashcat binwalk testdisk sqlmap steam
      lutris retroarch wine gamemode orca onboard kdeaccessibility espeak-ng brltty
    )
    ;;
  default)
    PACKAGES=(
      firefox-esr thunderbird libreoffice-writer libreoffice-calc libreoffice-impress
      vlc okular gimp inkscape konsole dolphin
    )
    ;;
  *)
    echo "Unknown bundle: $BUNDLE"
    echo "Valid values: productivity, developer, maker, security-learning, gaming, accessibility, all"
    exit 1
    ;;
esac

sudo apt-get update
sudo apt-get install -y "${PACKAGES[@]}"

printf '\nBundle "%s" installation completed.\n' "$BUNDLE"
