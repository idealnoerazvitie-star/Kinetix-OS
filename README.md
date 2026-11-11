# Quantix OS

Quantix OS is a blue-and-white Linux desktop concept with a browser-based interactive preview. It takes inspiration from the welcoming desktop experience of Linux Mint, performance-oriented distributions such as CachyOS, and the maker/education ecosystem around Raspberry Pi OS.

## Run the preview

Open `index.html` in a modern browser, or serve this directory with any static web server. No build step, dependencies, account, or network connection is required. The preview stores notes and the app-list state in your browser's local storage.

## Preview features

- Desktop, application launcher, dock, clock, and responsive layout.
- Searchable Quantix Store catalog with **400 community software listings** across 10 categories, including office, graphics, development, games, maker tools, privacy, and accessibility.
- Demo Files, Notes (saved locally), Settings, Terminal, and Browser windows.
- Add/remove catalog entries from the local preview app list.

## Important: prototype, not an installable operating system

This repository is currently a browser UI prototype. It is **not** a bootable Linux distribution, does not include a Linux kernel or installer, and does not download or execute the third-party apps shown in the catalog. The catalog entries are discovery listings, not a claim that the apps are installed, audited, or guaranteed malware-free. A real distro and production app store require signed package repositories, verified maintainers, security review and updates, licensing metadata, an installer, hardware testing, and release images. Use official upstream package sources and verify signatures before installing software.

The preview's app store intentionally simulates adding an app locally; it does not install third-party code. The built-in Notes and desktop settings are interactive, and the terminal accepts a small set of safe preview commands only.

## License

No license has been selected for this repository yet. Third-party software names are listed for discovery and remain under their respective licenses and trademarks.
