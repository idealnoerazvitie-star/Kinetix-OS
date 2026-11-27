# Experimental ARM64 build

Kinetix's primary supported image remains Debian amd64. This repository now contains an **experimental ARM64 build path** for testing on ARM64 Linux hosts and ARM virtual machines.

## Build

Run the GitHub Actions workflow **Build experimental Kinetix ARM64 ISO** manually. It uses a native Ubuntu ARM64 runner, sets `KINETIX_ARCH=arm64`, and uploads an artifact named `kinetix-os-arm64-experimental-...`.

The artifact is a build result, not a supported release. The workflow currently checks that live-build produced an ISO and records its checksum and file type. It does **not** yet prove successful boot on Raspberry Pi hardware, Apple Silicon, UEFI ARM virtual machines, or other ARM devices.

## Kernel selection

`auto/config` selects the Debian Live architecture and matching kernel flavour from `KINETIX_ARCH`. The normal amd64 build remains the default when the variable is unset.

## Support policy

- amd64: primary image; use the normal build and QEMU validation workflow.
- arm64: experimental build only until boot tests and device-specific testing are added.
- Apple Silicon: use ARM64 virtualization only after the ARM64 image has passed UEFI/QEMU tests. The amd64 ISO requires x86 emulation and is not native.
- Raspberry Pi: no device-specific boot image, firmware, device tree, or bootloader configuration is promised by this generic ARM64 ISO.
