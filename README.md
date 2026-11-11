# Quantix OS — a real Linux distribution project

Quantix OS is a Debian-based Linux distribution project with a clean white-and-blue desktop identity. It aims to combine an approachable desktop, a large software catalog, performance-conscious defaults, and a flexible live ISO workflow for a modern KDE-based system.

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

## Roadmap and planned feature expansion

This repository now includes a practical expansion plan for turning the project into a more complete Linux desktop distribution. The goal is to merge the current Debian build with real user experience improvements and curated app bundles.

### Planned additions

- A first-boot configuration wizard for language, keyboard, user setup, and initial system review
- Quantix KDE branding with a custom wallpaper, login screen, app-launcher layout, and desktop defaults
- Multi-profile app bundles for productivity, development, maker work, security learning, gaming, and accessibility
- Terminal and shell experience improvements for Konsole, including aliases, prompt configuration, and developer tools
- Better package management and Flatpak integration for a polished software installation flow
- Release validation steps including boot tests, smoke checks, and checksum generation

For the full project roadmap, see [docs/roadmap.md](docs/roadmap.md).

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

The build downloads packages from the configured Debian repositories and can take a while. The resulting hybrid ISO should appear in the repository directory. Test it first in QEMU, GNOME Boxes, or another VM before using it on real hardware.

## Included distro building blocks

- **Desktop:** KDE Plasma with Neon-style polish, SDDM, and Debian's live installer.
- **Daily use:** Firefox ESR, Thunderbird, LibreOffice, VLC, GIMP, Inkscape, Dolphin, Konsole, Discover, and FileZilla.
- **System integration:** NetworkManager, Bluetooth, PipeWire audio, printing, firmware packages, and fwupd.
- **Software management:** Debian packages through APT/Synaptic, plus Flatpak and GNOME Software's Flatpak plugin. Flatpak remotes and trust policy still need to be configured and reviewed before broader end-user use.
- **Maker and education:** Thonny, GPIO Zero, Arduino, and Scratch packages where available for the selected Debian release.
- **Accessibility and maintenance:** Orca, Onboard, Timeshift, GParted, and common command-line utilities.

This borrows general ideas from other Linux distributions; it does not bundle their proprietary assets or claim to reproduce their entire feature sets. In particular, CachyOS-specific kernel optimization and branding are intentionally not treated as a direct upstream dependency for this repo.

## App catalog and security

The HTML catalog is a discovery/demo UI: its Add buttons only save a local preview state. The distro image includes normal Debian software management, but this project does **not** yet provide its own packaged app-store ecosystem or a signed release pipeline.

Before publishing a public ISO, add a release pipeline, verify package and ISO checksums/signatures, publish a vulnerability-reporting contact, document supported hardware, test installer and upgrade flows, and check all bundled software for licensing and security review.

## Bundles included in the feature plan

The project is now planned to include optional bundle definitions. See [docs/app-bundles.md](docs/app-bundles.md) for a practical package list by category.

- Productivity bundle
- Developer bundle
- Maker bundle
- Security learning bundle
- Gaming bundle
- Accessibility bundle

Additionally, a first-boot bootstrapping helper is provided in [scripts/quantix-firstboot.sh](scripts/quantix-firstboot.sh).

## Current limitations

This is an early distro scaffold, not a fully mature Mint/CachyOS/KDE Neon/Raspberry Pi OS replacement. It currently targets x86-64 only; it has no custom kernel, ARM image, custom installer branding, or full hardware support matrix yet. The repository is best understood as a Debian live-build foundation plus an interactive desktop concept and expanded roadmap.
