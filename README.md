# Quantix OS — a real Linux distribution project

Quantix OS is a Debian-based Linux distribution project with a clean white-and-blue desktop identity. It aims to combine an approachable desktop, a large software catalog, performance-conscious defaults, and Raspberry Pi-inspired learning and maker tools.

## What this repository contains now

- `index.html`: an interactive, browser-only desktop and app-catalog mockup.
- `auto/config` and `config/`: a Debian Live build configuration for an **amd64 x86-64 live/install image**, including a Debian installer and a curated package set.
- `scripts/build-iso.sh`: a helper to build the configured ISO on Debian.

## Neon OS-inspired additions

The Quantix project now includes a KDE/Neon-inspired feature layer to blend the polished desktop experience of KDE Neon with a cleaner Quantix visual identity:

- KDE Plasma desktop, SDDM login, Breeze theme, and Qt/KDE app ecosystem
- Dolphin file manager, Konsole terminal, Discover software center, System Settings, and KDE Connect
- Neon-style workflow: fast desktop search, widgets, app launcher, and customization-friendly system tools
- White/blue Quantix visual scheme layered on top of Plasma's modern desktop polish
- Qt apps such as Okular, KWrite, Gwenview, Spectacle, and KCalc for daily productivity

This keeps the OS approachable and modern while preserving the Quantix identity.

## Build a bootable ISO

On a Debian system or Debian VM, install the build tools:

```sh
sudo apt update
sudo apt install live-build debootstrap xorriso squashfs-tools
```

Clone this repository and run:

```sh
sudo ./scripts/build-iso.sh
```

The build downloads packages from the configured Debian repositories and can take a while. The resulting hybrid ISO should appear in the repository directory. Test it first in QEMU, GNOME Boxes, or VirtualBox. Hardware testing is essential before calling a release stable. The current target is `amd64`; ARM/Raspberry Pi images need separate hardware-specific boot firmware, kernel, partitioning and image-build work.

## Included distro building blocks

- **Desktop:** KDE Plasma with Neon-style polish, SDDM, and Debian's live installer.
- **Daily use:** Firefox ESR, Thunderbird, LibreOffice, VLC, GIMP, Inkscape, Dolphin, Konsole, Discover, and FileZilla.
- **System integration:** NetworkManager, Bluetooth, PipeWire audio, printing, firmware packages, and fwupd.
- **Software management:** Debian packages through APT/Synaptic, plus Flatpak and GNOME Software's Flatpak plugin. Flatpak remotes and trust policy still need to be configured and reviewed before release.
- **Maker and education:** Thonny, GPIO Zero, Arduino, and Scratch packages where available for the selected Debian release.
- **Accessibility and maintenance:** Orca, Onboard, Timeshift, GParted, and common command-line utilities.

This borrows general ideas from other Linux distributions; it does not bundle their proprietary assets or claim to reproduce their entire feature sets. In particular, CachyOS-specific kernel optimizations and Raspberry Pi OS hardware support are not enabled merely by including applications.

## App catalog and security

The HTML catalog is a discovery/demo UI: its Add buttons only save a local preview state. The distro image includes normal Debian software management, but this project does **not** yet provide its own production app-store backend, package-signing infrastructure, malware-scanning service, update service, or software-maintainer review process. No catalog can promise that every third-party application is malware-free. Install software only from trusted sources, verify signatures, and ship security updates promptly.

Before publishing a public ISO, add a release pipeline, verify package and ISO checksums/signatures, publish a vulnerability-reporting contact, document supported hardware, test installer and upgrade paths, and establish a security update policy. Do not use the project for sensitive systems until it has been independently tested.

## Current limitations

This is an early distro scaffold, not a fully mature Mint/CachyOS/KDE Neon/Raspberry Pi OS replacement. It currently targets x86-64 only; it has no custom kernel, ARM image, custom installer branding, secure-boot signing, release CI, update infrastructure, or independent package repository. Those require additional implementation and real-device testing. The package list should be validated by running the ISO build; remove or adjust any package that is unavailable in Debian Trixie.
