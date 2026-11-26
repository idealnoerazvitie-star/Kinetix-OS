# Kinetix OS roadmap

## Goal

Kinetix OS is intended to become a polished Debian-based desktop distribution with a clean white-and-blue KDE identity. The repo currently combines:

- a Debian Live build configuration
- a browser-based desktop mockup
- planned app bundle and user-experience layers

The purpose is to move from a concept project to a practical, bootable Linux desktop distribution with modern defaults and optional specialized bundles.

## Core product direction

### 1. First-boot experience

Users should see a guided setup flow on first login that includes:

- language and locale selection
- keyboard layout
- timezone setup
- user account creation
- Wi-Fi onboarding
- update and driver detection
- choice of desktop profile

**Current status:** `scripts/kinetix-firstboot.sh` ships inside the image and is wired to autostart once per new user. It currently sets shell aliases, creates a small profile file, and shows an optional welcome notification. It is not yet a guided configuration wizard. Language, keyboard, timezone, and account creation remain part of Debian's installer; post-install Wi-Fi onboarding and driver detection are not implemented.

### 2. KDE desktop identity

Kinetix should ship with:

- KDE Plasma desktop
- Breeze/Qt theming
- SDDM login theme
- white and blue Kinetix visual identity
- sensible panel/dock layout
- default file manager and terminal configuration

The current image uses upstream Breeze defaults; custom Kinetix wallpaper, SDDM artwork, and a Plasma look-and-feel package remain to be built.

### 3. App bundles

The optional package groups are defined in `config/app-bundles.yaml` and documented in [app-bundles.md](app-bundles.md). They are definitions only: no graphical app-bundle installer currently consumes this YAML.

### 4. Terminal experience

A modern Linux desktop needs a strong terminal workflow. Kinetix currently includes a small set of aliases and Fastfetch. A branded Konsole theme, optional Starship prompt, and a fuller developer environment remain planned.

### 5. Software management

The OS currently uses Debian APT/Synaptic and KDE Discover with the Flatpak backend. Flatpak remotes and trust policy must be configured and reviewed before broad end-user use. The HTML app catalog is a browser demo and does not install software.

### 6. Quality and release validation

The project should include automated release checks:

- full ISO build
- boot smoke test in QEMU/VirtualBox
- installer smoke test
- package and dependency validation
- checksum and signature generation
- release notes

## Suggested milestone plan

### Phase 1: Desktop baseline

- finish Debian live build stability
- verify KDE Plasma works in the live environment
- tune SDDM and desktop defaults
- verify default apps and package list

### Phase 2: User onboarding

- implement first-boot configuration flow
- add welcome message, defaults, and profile selection
- add initial system update instructions

### Phase 3: Bundles

- define default app bundles
- provide package lists for each bundle
- add an actual installer workflow and update handling

### Phase 4: Release quality

- create signed checksums
- publish release notes
- test hardware compatibility
- add documentation for supported devices

## Package list and dependency validation

The CI workflows now provide two layers of validation:

- `.github/workflows/validate-live-build.yml` checks package availability, simulates APT dependency resolution for the base image and optional bundles, runs `lb config`, checks shell syntax and first-boot script parity, and runs regression tests.
- `.github/workflows/build-iso.yml` performs a full `lb build` inside a privileged Debian Trixie container, checks the ISO boot catalog, starts the ISO in QEMU using software emulation, switches to a text console, captures a screenshot, and uses OCR to look for a Debian/Kinetix login prompt. It uploads the ISO, SHA-256 checksum, and boot diagnostics as a 14-day workflow artifact.
- Pushing a `v*` tag publishes a GitHub Release only after the build and QEMU boot job succeeds.

The QEMU job tests a BIOS-mode virtual machine. It is not an installer qualification test and cannot certify Wi-Fi, Bluetooth, audio, graphics acceleration, suspend/resume, firmware, or other physical hardware. The checksum detects accidental corruption but is not a cryptographic publisher signature. Follow [hardware-testing.md](hardware-testing.md) on physical devices and use a disposable VM disk for installer testing.
