# Kinetix OS — a real Linux distribution project

Kinetix OS is a Debian-based Linux distribution project with a clean white-and-blue desktop identity. It aims to combine an approachable desktop, a large software catalog, performance-conscious defaults, and a flexible live ISO workflow for a modern KDE-based system.

# Kinetix OS system requirements

## Minimum recommended hardware

- Processor: 64-bit x86-64 compatible CPU
- RAM: 4 GB minimum
- Storage: 20 GB free disk space
- Graphics: Vulkan-capable or OpenGL-capable GPU recommended
- Network: Ethernet or Wi-Fi support

## Recommended hardware

- Processor: modern 64-bit CPU
- RAM: 8 GB or more
- Storage: 40 GB or more
- Display: 1080p or better
- Network: internet connection for package updates

## Notes

- Kinetix OS is currently focused on x86-64 desktop systems.
- Hardware compatibility will improve as the distro matures.
- Use a VM to test the ISO before installing on real hardware.

## What this repository contains now

- `index.html`: an interactive, browser-only desktop and app-catalog mockup.
- `auto/config` and `config/`: a Debian Live build configuration for an **amd64 x86-64 live/install image**, including a Debian installer and a curated package set.
- `config/includes.chroot/`: files copied verbatim into the built system — the first-boot script at `/usr/local/bin/kinetix-firstboot.sh` and an XDG autostart entry (via `/etc/skel`) that runs it once per new user.
- `scripts/build-iso.sh`: a helper to build the configured ISO on Debian.
- `scripts/verify-iso.sh`: validates the ISO boot catalog and boots it in QEMU, checking for a Debian/Kinetix login console.
- `scripts/hardware-report.sh`: collects a read-only hardware and driver inventory for physical-device testing.

## Neon OS-inspired additions

The Kinetix project now includes a KDE/Neon-inspired feature layer to blend the polished desktop experience of KDE Neon with a cleaner Kinetix visual identity:

- KDE Plasma desktop, SDDM login, Breeze theme, and Qt/KDE app ecosystem
- Dolphin file manager, Konsole terminal, Discover software center, System Settings, and KDE Connect
- Neon-style workflow: fast desktop search, widgets, app launcher, and customization-friendly system tools
- White/blue Kinetix visual scheme layered on top of Plasma's modern desktop polish
- Qt apps such as Okular, KWrite, Gwenview, KDE Spectacle, and KCalc for daily productivity

This keeps the OS approachable and modern while preserving the Kinetix identity.

## Roadmap and planned feature expansion

This repository now includes a practical expansion plan for turning the project into a more complete Linux desktop distribution. The goal is to merge the current Debian build with real user experience improvements and curated app bundles.

### Planned additions

- A first-boot configuration wizard for language, keyboard, user setup, and initial system review
- Kinetix KDE branding with a custom wallpaper, login screen, app-launcher layout, and desktop defaults
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

The build downloads packages from the configured Debian repositories and can take a while. The resulting hybrid ISO should appear in the repository directory. To verify it locally, install `qemu-system-x86`, `qemu-utils`, `xorriso`, `socat`, `procps`, `python3-pil`, and `tesseract-ocr`, then run `bash scripts/verify-iso.sh path/to/image.iso`. The `Build and boot-test Kinetix ISO` GitHub Actions workflow performs the full build, QEMU boot smoke test, and SHA-256 generation on pull requests and pushes to `main`; it also supports manual runs. The resulting ISO and diagnostic evidence are uploaded as a workflow artifact for 14 days.

## Included distro building blocks

- **Desktop:** KDE Plasma with Neon-style polish, SDDM, and Debian's live installer.
- **Daily use:** Firefox ESR, Thunderbird, LibreOffice, VLC, GIMP, Inkscape, Dolphin, Konsole, Discover, and FileZilla.
- **System integration:** NetworkManager, Bluetooth, PipeWire audio, printing, firmware packages, and fwupd.
- **Software management:** Debian packages through APT/Synaptic, plus Flatpak through KDE Discover's Flatpak backend. Flatpak remotes and trust policy still need to be configured and reviewed before broader end-user use.
- **Maker and education:** Thonny, GPIO Zero, and Arduino. (Scratch is intentionally left out — the `scratch` package was dropped from Debian's repositories and is not installable on trixie; see [docs/app-bundles.md](docs/app-bundles.md) for a note on alternatives.)
- **Accessibility and maintenance:** Orca, Onboard, Timeshift, GParted, and common command-line utilities.

This borrows general ideas from other Linux distributions; it does not bundle their proprietary assets or claim to reproduce their entire feature sets. In particular, CachyOS-specific kernel optimization and branding are intentionally not treated as a direct upstream dependency for this repo.

## App catalog and security

The HTML catalog is a discovery/demo UI: its Add buttons only save a local preview state. The distro image includes normal Debian software management, but this project does **not** yet provide its own packaged app-store ecosystem or cryptographically signed ISO releases.

A vulnerability-reporting process is now published in [SECURITY.md](SECURITY.md). Tagged `v*` releases are published automatically only after the ISO build and QEMU boot test pass; the release includes a SHA-256 checksum. This checksum detects accidental corruption but is not a cryptographic publisher signature. Physical hardware, installer, upgrade, licensing, and security qualification remain release gates; see [docs/hardware-testing.md](docs/hardware-testing.md).

## Bundles included in the feature plan

The project is now planned to include optional bundle definitions. See [docs/app-bundles.md](docs/app-bundles.md) for a practical package list by category.

- Productivity bundle
- Developer bundle
- Maker bundle
- Security learning bundle
- Gaming bundle
- Accessibility bundle

Additionally, a first-boot bootstrapping helper is provided in [scripts/kinetix-firstboot.sh](scripts/kinetix-firstboot.sh).

## Current limitations

This is an early distro scaffold, not a fully mature Mint/CachyOS/KDE Neon/Raspberry Pi OS replacement. It currently targets x86-64 only; it has no custom kernel, ARM image, custom installer branding, or full hardware support matrix yet. The repository is best understood as a Debian live-build foundation plus an interactive desktop concept and expanded roadmap.

The package lists were cross-checked against Debian trixie's current package set (see [docs/roadmap.md](docs/roadmap.md#package-list-audit)) to remove entries that would make `apt`/`lb build` fail. The GitHub Actions workflows validate package availability and dependency resolution, check the Debian Live configuration and shell scripts, then build the full hybrid ISO and attempt a QEMU boot to a recognizable login console. The ISO and diagnostic evidence are uploaded as a 14-day artifact. Tagged `v*` releases are published only after that build and boot check pass. A SHA-256 checksum is included, but it is not a publisher signature. These automated checks still do not certify physical hardware, installer partitioning, upgrades, or long-term operation. See [docs/hardware-testing.md](docs/hardware-testing.md) for the manual qualification plan. The promised white/blue Kinetix visual identity (custom wallpaper, SDDM/login theme artwork, Plasma look-and-feel package) remains future work.
