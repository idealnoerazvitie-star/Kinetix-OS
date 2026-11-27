# Kinetix OS software bundles

Kinetix uses KDE Plasma, Papirus application icons and Breeze desktop styling. Optional software is grouped into bundles so users install only what they need.

## Install a bundle

```sh
kinetix-bundle --list
kinetix-bundle --dry-run gaming
sudo kinetix-bundle productivity
sudo kinetix-bundle creative
sudo kinetix-bundle gaming
```

The installer validates Debian package names and Flatpak IDs. Debian packages come from configured Debian repositories. Flathub is added only when the user explicitly installs a bundle containing Flatpak apps.

## Bundles

| Category | Examples |
|---|---|
| Productivity | LibreOffice, Thunderbird, Okular, KeePassXC, Syncthing, Nextcloud Desktop, Obsidian, Zotero |
| Internet | Firefox ESR, Chromium, qBittorrent, Remmina, Telegram, Signal, Discord |
| Creative | GIMP, Inkscape, Krita, Blender, Darktable, FreeCAD, Kdenlive, OBS |
| Multimedia | VLC, MPV, Audacity, HandBrake, Ardour, LMMS, Spotify |
| Developer | Git, GCC, CMake, Clang, Python, Node.js, Rust, Go, Java, Docker, Podman, VS Code |
| Maker | Arduino, Thonny, KiCad, Fritzing, OpenSCAD, FreeCAD |
| Science & education | Stellarium, KStars, GCompris, Anki, Octave, GeoGebra |
| Security learning | Nmap, Wireshark, tcpdump, Aircrack-ng, John, Hashcat, TestDisk, Lynis |
| Gaming | Steam, Lutris, RetroArch, DOSBox, ScummVM, OpenTTD, SuperTuxKart, 0 A.D., Xonotic, Heroic, Bottles |
| Accessibility | Orca, Onboard, speech-dispatcher, eSpeak NG, KMagnifier |
| System | Timeshift, BleachBit, GParted, Synaptic, CPU-X, Hardinfo, Flatseal |

## PC games, GTA and classic action games

The gaming bundle installs launchers, emulators and open-source games. Steam, Lutris, Heroic and Bottles help install games from stores and manage Windows titles through Proton/Wine.

Kinetix does not include pirated game files, copyrighted GTA data, cracked executables or game assets. For GTA III, Vice City, San Andreas and other commercial games, install a legitimate copy you own through a supported store or configure a legally obtained copy in Lutris/Bottles. Compatibility depends on the game version, GPU driver and Proton/Wine version. Some titles require community fixes.

The installer enables i386 architecture when installing Debian's Steam package on amd64. Suitable graphics drivers and Vulkan support are recommended.

## Wallpaper and icons

The **Change Wallpaper** application opens a native file picker and applies the selected image to the KDE Plasma desktop. The same controls remain available in System Settings → Wallpaper.

The desktop uses real upstream Papirus/Breeze icons and application-provided icons rather than emoji tiles or invented logos. KDE Discover provides the graphical software center.

## Limitations

Bundles are optional and never install automatically. Package availability is checked against Debian Trixie in CI; Flatpak IDs are syntax-checked and resolved by Flathub at install time. CI cannot guarantee every app or game works on every GPU, machine or game release. Commercial games require a valid license and separately obtained game files.
