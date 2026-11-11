# Quantix OS app bundles

This document defines the planned package groups for Quantix OS. The goal is to keep the distro approachable while offering specialized profiles for different user types.

## 1. Productivity bundle

Description: general-purpose desktop set for work, study, and daily use.

Packages:

- firefox-esr
- thunderbird
- libreoffice-writer
- libreoffice-calc
- libreoffice-impress
- vlc
- okular
- gimp
- inkscape
- filezilla
- keepassxc
- nextcloud-client

## 2. Developer bundle

Description: code, shell, tooling, and development environment.

Packages:

- git
- build-essential
- curl
- wget
- jq
- ripgrep
- fd-find
- htop
- vim
- neovim
- python3
- python3-pip
- nodejs
- npm
- docker.io
- docker-compose-plugin
- code
- geany
- gdb

## 3. Maker bundle

Description: learning, microcontrollers, electronics, and maker tasks.

Packages:

- thonny
- python3-gpiozero
- arduino
- scratch
- raspberrypi-ui
- libreoffice-calc
- gparted

## 4. Security learning bundle

Description: educational and defensive tools for Linux security and networking practice.

Packages:

- nmap
- wireshark
- tcpdump
- aircrack-ng
- john
- hashcat
- binwalk
- gdb
- netcat-openbsd
- testdisk
- steghide
- sqlmap

## 5. Gaming bundle

Description: gaming and entertainment on a desktop Linux environment.

Packages:

- steam
- lutris
- retroarch
- wine
- gamemode
- protontricks

## 6. Accessibility bundle

Description: accessibility and assistive tools for daily use.

Packages:

- orca
- onboard
- kdeaccessibility
- espeak-ng
- brltty
- gnome-accessibility-tools

## Flatpak recommendation

Where Debian package availability is limited or the app is better served via Flatpak, the following are recommended:

- Signal Desktop
- Discord
- Spotify
- VS Code (if packaged version is insufficient)
- Obsidian
- Bitwarden
- Blender
- Krita

## Deployment note

These bundles are not meant to be forced onto every user. They are best treated as optional preset profiles or installation groups, while the default Quantix install remains lightweight and usable by default.
