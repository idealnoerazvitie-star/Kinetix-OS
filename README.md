# Kinetix OS — lightweight Debian KDE desktop

Kinetix OS is a lightweight Debian-based desktop project built around KDE Plasma. The default live image focuses on a usable desktop, networking, firmware, and a small set of everyday utilities. Gaming, development, and security-learning tools are optional so users install only what they need.

## Project status

This is an early live-build project, not a mature or security-certified distribution. The repository provides a Debian Live build configuration and a browser-only desktop mockup. The mockup is not a real package manager, and optional scripts and package groups need testing against the target Debian release before use.

## Current design

- **Base:** Debian Trixie, amd64, live/install ISO
- **Desktop:** KDE Plasma with Breeze defaults and Konsole
- **Lightweight policy:** APT recommendations disabled for the ISO; optional tools are not in the base package list
- **Optional gaming:** install selected launchers and runtime tools with `scripts/install-gaming-bundle.sh`
- **Optional performance tools:** `scripts/install-performance-tools.sh` offers utilities without changing kernel parameters or overclocking
- **Optional security learning:** a small defensive-oriented package group through `scripts/install-bundle.sh security-learning`

Kinetix borrows general ideas such as a performance-conscious desktop and modular tool selection. It is not a Kali or CachyOS clone and does not ship a large penetration-testing suite or custom kernel by default.

## Build the ISO

On a Debian build host or VM:

```sh
sudo apt update
sudo apt install live-build debootstrap xorriso squashfs-tools
sudo ./scripts/build-iso.sh
```

The build downloads packages from Debian repositories and may take a while. Test the resulting image in a virtual machine before installing it on hardware. See [docs/release-pipeline.md](docs/release-pipeline.md) and [docs/known-limitations.md](docs/known-limitations.md).

## Optional bundles

Examples (internet access and administrator permissions required):

```sh
./scripts/install-bundle.sh productivity
./scripts/install-bundle.sh developer
./scripts/install-bundle.sh security-learning
./scripts/install-gaming-bundle.sh runtime
./scripts/install-gaming-bundle.sh launchers
./scripts/install-performance-tools.sh
```

Package availability depends on the enabled Debian repository components, architecture, and release. Review commands and package choices before running them. Security assessment tools should only be used on systems and networks you own or are explicitly authorized to test.

## Branding and packaging

The live image identifies itself as **Kinetix OS** through `auto/config` and the files under `config/includes.chroot/etc/`. The repository is named `Kinetix-OS`. The existing `index.html` remains a browser demo and may still contain legacy Quantix branding; it is not part of the installed operating system.

## Before a public release

Build and boot-test the ISO, verify installer and networking behavior, review package availability and licensing, document supported hardware, publish signed checksums, and replace template security-contact information with a monitored contact. No ISO build or VM test is claimed by this repository update.
