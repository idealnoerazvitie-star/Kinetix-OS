# Kinetix OS roadmap

## Goal

Kinetix OS is intended to become a polished Debian-based desktop distribution with a clean white-and-blue KDE identity. The repo currently combines:

- a Debian Live build configuration
- a browser-based desktop mockup
- a planned app bundle and user-experience layer

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

This should be driven by a small script on the live desktop and a persistent marker so it runs only once.

**Status:** `scripts/kinetix-firstboot.sh` now ships inside the built image (via `config/includes.chroot`) and is wired to autostart once per new user through an XDG autostart entry under `/etc/skel`. Today it only sets shell aliases, a profile marker, and a welcome notification — the language/keyboard/timezone/account steps above are still handled by Debian's own live-installer during install, not by this script, and a guided post-install wizard covering Wi-Fi onboarding and driver detection is still unbuilt.

### 2. KDE desktop identity

Kinetix should ship with:

- KDE Plasma desktop
- Breeze/Qt theming
- SDDM login theme
- white and blue Kinetix visual identity
- sensible panel/dock layout
- default file manager and terminal configuration

### 3. App bundles

The distro should ship with clearly separated installation profiles instead of a single giant package set. The bundle approach helps the project stay manageable and approachable.

Recommended bundles:

- Productivity
- Developer
- Maker
- Security learning
- Gaming
- Accessibility

These can be installed in the live environment or modeled as package lists for ISO customization.

### 4. Terminal experience

A modern Linux desktop needs a strong terminal workflow. Kinetix should include:

- Konsole with a Kinetix theme
- shell aliases for common tasks
- `fastfetch`/`neofetch`
- developer-ready packages like `git`, `curl`, `wget`, `ripgrep`, `fd`, `jq`, and `htop`
- optional `starship` prompt

### 5. Software management

The OS should support:

- APT packages from Debian repos
- Flatpak applications from configured remotes
- app categories for easier discovery
- a clear separation between the browser mockup and actual package installation

### 6. Quality and release validation

The project should include automated release checks:

- ISO build check
- boot smoke test in QEMU/VirtualBox
- installer smoke test
- package validation
- checksum generation
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
- add documentation for install and update workflows

### Phase 4: Release quality

- create signed checksums
- publish release notes
- test hardware compatibility
- add documentation for supported devices

## File additions in this branch

This branch includes:

- `scripts/kinetix-firstboot.sh` — a first-boot helper script, now also installed into the image at `config/includes.chroot/usr/local/bin/` with an autostart entry under `config/includes.chroot/etc/skel/.config/autostart/`
- `config/app-bundles.yaml` — bundle definitions and package suggestions
- `docs/app-bundles.md` — detailed app bundle documentation

These additions are meant to give the project a practical foundation, not to replace the Debian live-build configuration itself.

## Package list audit

The base package list (`config/package-lists/kinetix.list.chroot`) and `config/app-bundles.yaml` / `docs/app-bundles.md` were checked against Debian trixie's actual package set. Packages removed because they no longer exist in trixie and would make `apt`/`lb build` fail outright:

- `ksnapshot` — KDE4-era screenshot tool, superseded by `spectacle` (already included) and long gone from Debian
- `scratch` — depends on an unmaintained Squeak runtime; removed from Debian's repositories
- `raspberrypi-ui-mods` — belongs to Raspberry Pi OS's own apt repository, not Debian

Also dropped `gnome-software` and `gnome-software-plugin-flatpak` from the base image: they exist in trixie but duplicate what KDE Discover + `plasma-discover-backend-flatpak` already provide, and pulling in the GNOME Software stack on a KDE-first spin works against the "clean KDE identity" goal. `code` (VS Code) was dropped from the developer bundle doc since it is not packaged in Debian's own repositories at all; it stays as a Flatpak recommendation.

This audit was done by cross-checking Debian's package tracker and `packages.debian.org`, not by a real `lb build` run — see "Current limitations" below.
