# Kinetix OS roadmap

## Product direction

Kinetix OS is a Debian Trixie-based amd64 desktop distribution using KDE Plasma. The project prioritizes familiar upstream Linux software, maintainable packages and native desktop behavior over a custom browser simulation.

## Implemented

### Desktop and appearance
- KDE Plasma, SDDM, Breeze widgets and window styling.
- Papirus icon theme for recognizable application icons.
- GTK defaults aligned with Breeze and Papirus.
- Native Change Wallpaper launcher that opens a KDE file picker and applies the selected image through Plasma.
- KDE Discover, Dolphin, Konsole, System Settings and KDE Connect.

### Software installation
- kinetix-bundle --list lists optional software groups.
- kinetix-bundle --dry-run <bundle> previews installation.
- sudo kinetix-bundle <bundle> installs Debian packages and/or Flatpak applications.
- Flathub is configured only when a user explicitly installs a bundle containing Flatpak apps.

### Application and game categories
Productivity, internet, creative work, multimedia, developer tools, maker/electronics, science/education, security learning, gaming, accessibility and system maintenance. The gaming profile includes Steam, Lutris, RetroArch, DOSBox, ScummVM and open-source games, with Heroic, Bottles and emulators available from Flathub. Commercial games such as GTA require a valid user-owned copy and are not bundled.

## Remaining milestones

### First-boot setup
- Guided locale, keyboard, timezone and hardware setup.
- Optional desktop profile selection.
- Clear update and driver guidance.

### Graphical software experience
- Add a graphical Kinetix bundle selector that calls the validated installer.
- Show package source, license, size and maintainer information.
- Preserve KDE Discover as the normal APT/Flatpak software center.

### Release quality
- Test on physical Intel, AMD and NVIDIA hardware.
- Verify installer partitioning, Wi-Fi, Bluetooth, audio, suspend/resume and GPU acceleration.
- Add signed release checksums and release notes.
- Document supported hardware and known game compatibility.

## Automated validation

GitHub Actions verify Debian package availability and dependency resolution, validate Debian Live configuration, check shell syntax and regression tests, build the hybrid ISO and attempt a BIOS-mode QEMU boot smoke test.

QEMU testing does not certify real hardware, installer partitioning, Wi-Fi, graphics acceleration, game compatibility or long-term operation. The SHA-256 checksum detects accidental corruption but is not a cryptographic publisher signature. See hardware-testing.md before installing on a physical computer.
