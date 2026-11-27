# Kinetix OS — Debian KDE desktop distribution

Kinetix OS is an early Debian Trixie-based Linux distribution for amd64 computers. It uses KDE Plasma, Papirus application icons, Breeze styling and real Linux applications.

## Desktop

- KDE Plasma desktop and SDDM login manager
- Papirus icon theme with Breeze widgets and window styling
- Dolphin, Konsole, KDE Discover, System Settings and KDE Connect
- Reference-inspired Plasma layout: top system/menu panel, bottom application dock, desktop shortcuts and virtual desktop pager
- Original blue Kinetix alpine-lake wallpaper enabled by default
- Native Change Wallpaper launcher for selecting and applying desktop images
- NetworkManager, Bluetooth, PipeWire audio, printing and firmware packages

The desktop uses upstream application icons rather than emoji tiles or generated-looking logos. The HTML page in this repository is a simple project landing page, not a simulated desktop.

## Software bundles

Optional bundles cover productivity, internet, creative work, multimedia, development, electronics/maker projects, science and education, security learning, gaming, accessibility and system maintenance.

List bundles:

```sh
kinetix-bundle --list
```

Preview a bundle:

```sh
kinetix-bundle --dry-run gaming
```

Install a bundle:

```sh
sudo kinetix-bundle gaming
```

The installer supports Debian packages and Flatpak applications. Flathub is added only when a user explicitly installs a bundle that contains Flatpak apps.

## Games

The gaming bundle includes Steam, Lutris, RetroArch, DOSBox, ScummVM, OpenTTD, SuperTuxKart, 0 A.D., Warzone 2100, Xonotic and other open-source games. Heroic Games Launcher, Bottles and additional emulators are available through Flathub.

Desktop shortcuts for GTA III, Vice City and San Andreas launch their Steam entries when the user owns and has installed those games. Minecraft is launched through Prism Launcher after installing the Games bundle. Commercial games such as Grand Theft Auto require a legitimate copy and their own game files. The shortcuts do not bundle or bypass game licensing. Kinetix does not distribute copyrighted game data, cracked executables or pirated copies. Compatibility depends on the game, GPU drivers and Proton/Wine version.

## Build a bootable ISO

On Debian, install build tools:

```sh
sudo apt update
sudo apt install live-build debootstrap xorriso squashfs-tools
```

Then run:

```sh
sudo ./scripts/build-iso.sh
```

The build downloads packages from Debian repositories and may take a while. To test an ISO locally, install qemu-system-x86, qemu-utils, xorriso, socat, procps, python3-pil and tesseract-ocr, then run:

```sh
bash scripts/verify-iso.sh path/to/image.iso
```

GitHub Actions validates package availability, dependencies, shell scripts and Debian Live configuration, then builds the ISO and attempts a BIOS-mode QEMU boot test. Workflow artifacts are retained for 14 days.

## Hardware and release status

Kinetix is an early project, not yet a fully qualified replacement for Linux Mint or Zorin OS. It currently targets x86-64 only. Physical hardware, installer partitioning, Wi-Fi, Bluetooth, audio, graphics acceleration, suspend/resume and game compatibility still require manual testing. SHA-256 checksums detect accidental corruption but are not publisher signatures.

See docs/app-bundles.md for bundle details, docs/roadmap.md for planned work and docs/hardware-testing.md for the physical-device test plan.
