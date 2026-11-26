# Kinetix OS app bundles

This document defines the planned package groups for Kinetix OS. The goal is to keep the distro approachable while offering specialized profiles for different user types.

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
- docker-compose
- geany
- gdb

VS Code is not packaged in Debian's own repositories; it is offered as a Flatpak below instead of an apt package here.

## 3. Maker bundle

Description: learning, microcontrollers, electronics, and maker tasks.

Packages:

- thonny
- python3-gpiozero
- arduino
- libreoffice-calc
- gparted

Scratch is deliberately left out: the `scratch` package was dropped from Debian's repositories (it depends on an unmaintained Squeak-based runtime) and is not installable on trixie. `raspberrypi-ui-mods`, sometimes suggested for a "maker" look, is specific to Raspberry Pi OS's own apt repository and is not available on a generic Debian amd64 system like Kinetix — it is not included here.

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

- steam-installer
- lutris
- retroarch
- wine
- gamemode
- protontricks

The Steam package is named `steam-installer` for amd64 in Debian Trixie. Steam requires 32-bit compatibility libraries, so enable the i386 architecture before installing it:

```sh
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install steam-installer
```

Make sure the system has suitable graphics drivers and Vulkan support for the GPU before expecting modern games to run well.

## 6. Accessibility bundle

Description: accessibility and assistive tools for daily use.

Packages:

- orca
- onboard
- kdeaccessibility
- espeak-ng
- brltty

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

These bundles are package suggestions, not an implemented graphical installer. They are not forced onto every user; the default Kinetix install remains a separate, lighter package set. Dependency checks in CI simulate installation of each bundle against Debian Trixie.
