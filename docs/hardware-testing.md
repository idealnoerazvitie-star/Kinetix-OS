# Kinetix OS hardware validation

This checklist is for testing a built ISO on physical hardware. Passing the GitHub Actions QEMU job only proves that the image boots in an emulated x86-64 machine; it does not certify Wi-Fi chipsets, Bluetooth adapters, GPUs, suspend/resume, audio devices, or firmware updates on real computers.

## Before testing

- Back up important data before attempting installation.
- Test the live session first; do not install until the live desktop and network are stable.
- Record the computer model, CPU, GPU, Wi-Fi adapter, and BIOS/UEFI version.
- Disconnect external storage that is not needed for testing.
- Never publish reports containing serial numbers, MAC addresses, usernames, or other private identifiers.

## Live-session checklist

- [ ] ISO boots in UEFI mode.
- [ ] ISO boots in legacy BIOS mode where supported.
- [ ] KDE Plasma reaches the desktop without a black screen or repeated login loop.
- [ ] Display resolution, scaling, multiple monitors, and graphics acceleration work.
- [ ] Wi-Fi can scan, connect, disconnect, and reconnect after reboot.
- [ ] Ethernet obtains an address and reaches the network.
- [ ] Bluetooth can discover and pair with a known device.
- [ ] Audio output and microphone input work; volume and mute controls work.
- [ ] Suspend, resume, screen lock, and shutdown work.
- [ ] Touchpad, keyboard, function keys, webcam, and card reader work where present.
- [ ] USB storage mounts and safely ejects.
- [ ] Battery status and brightness controls work on laptops.
- [ ] Firmware updater detects devices without attempting an unreviewed firmware flash.

## Collect a diagnostic report

Run from the live desktop:

```sh
sudo apt update
sudo apt install pciutils usbutils rfkill network-manager bluez \
  pipewire-audio wireplumber alsa-utils mesa-utils vulkan-tools
bash scripts/hardware-report.sh ~/kinetix-hardware-report.txt
```

The report script is read-only. It redacts standard MAC-address and firmware serial-number fields automatically. Still review the output before sharing it, because host-specific names or unusual vendor fields may remain. A missing utility is reported as unavailable, not treated as proof that the hardware is unsupported.

## Installer and installed-system checks

- [ ] Debian installer starts from the live environment.
- [ ] Disk selection and partition review show the intended target before writing.
- [ ] Installation completes in a disposable VM or spare drive.
- [ ] The installed system boots without the ISO attached.
- [ ] A normal user can log in and obtain network access.
- [ ] Bootloader works in the tested UEFI/BIOS mode.
- [ ] APT update and upgrade complete without broken packages.
- [ ] Reboot, shutdown, suspend/resume, audio, and graphics work after installation.

Do not test destructive partitioning against a machine containing important data. Use a disposable virtual disk for installer qualification.

## Recording results

For each machine, record the date, ISO SHA-256, machine model, tested firmware mode, device IDs (PCI/USB IDs are sufficient), pass/fail result, and concise reproduction steps. Keep raw logs private until identifiers have been removed.
