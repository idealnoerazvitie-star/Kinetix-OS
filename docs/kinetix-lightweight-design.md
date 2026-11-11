# Kinetix OS branding and lightweight profile

The Debian Live image is branded Kinetix OS through its ISO metadata (`auto/config`) and chroot includes (`config/includes.chroot/etc/`). The current repository name is `Kinetix-OS`.

## Lightweight defaults

- Debian Trixie and amd64 only
- KDE Plasma desktop; no second desktop environment
- APT recommends disabled while building the image to reduce incidental packages
- One browser and essential desktop utilities in the base package list
- Gaming, developer, maker, productivity extras, performance helpers, and security-learning tools remain optional

Smaller package selections do not guarantee a particular ISO size or performance. Build and measure the image, then test boot, hardware support, and core workflows before release.

## Performance and gaming

Optional helpers are documented in:

- [Gaming features](gaming-features.md)
- [CachyOS-inspired performance ideas](cachyos-inspired-performance.md)

These do not install a custom kernel, modify boot parameters, overclock hardware, or install proprietary drivers automatically. Choose GPU drivers using Debian's official documentation for the specific GPU and Debian release.

## Branding caveat

The current `index.html` is a browser-only desktop mockup and still contains legacy Quantix labels and a large sample app catalog. It is not included in the live image package list and does not install or launch native applications. Update that page separately before presenting it as Kinetix-branded documentation or a real desktop preview.
