# CachyOS-inspired performance without a heavy base

Quantix can adopt the *ideas* of a responsive, performance-conscious desktop while remaining Debian-based and avoiding an untested replacement kernel. This is an optional tuning layer, not a port of CachyOS or its packages, kernel, branding, or build system.

## Lightweight defaults

- Keep the base image on Debian's supported kernel and KDE Plasma; don't add gaming launchers, compiler toolchains, or tuning daemons to the default ISO.
- Keep the app and performance add-ons opt-in through `scripts/install-performance-tools.sh` and `scripts/install-gaming-bundle.sh`.
- Prefer Debian-supported packages and hardware drivers. Performance and compatibility depend on the machine, firmware, GPU, and game.

## Optional performance tools

Run:

```sh
./scripts/install-performance-tools.sh
```

This installs available Debian packages for compressed swap in RAM (`zram-tools`) and system tuning (`tuned`), using `--no-install-recommends`. Review each tool's defaults and documentation before enabling profiles or changing system settings. The script does not change CPU governor settings, boot parameters, kernel, or services automatically.

## Ideas to develop later

- Make responsiveness and gaming performance measurable with repeatable boot, idle-memory, and frame-time tests.
- Offer documented KDE defaults and per-user choices rather than applying aggressive system-wide tweaks.
- Consider a separately maintained, signed kernel only if the project can continuously test hardware, upgrades, security fixes, and rollback.

Do not promise a particular speedup: results vary by system and workload. Keep backups and a recovery path before changing kernel or boot configuration.
