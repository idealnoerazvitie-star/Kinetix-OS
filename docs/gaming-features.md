# Optional gaming features

Quantix keeps the base ISO small and lets users add gaming support only if they need it. The optional installer script uses Debian packages when available and skips packages unavailable from the system's configured repositories.

## Install

Install the gameplay runtime and overlays:

```sh
./scripts/install-gaming-bundle.sh runtime
```

Install optional launchers and compatibility tools:

```sh
./scripts/install-gaming-bundle.sh launchers
```

Or install both groups:

```sh
./scripts/install-gaming-bundle.sh all
```

The runtime group includes available packages such as GameMode, MangoHud, Gamescope, Vulkan tools, and Mesa utilities. The launcher group may include Lutris, RetroArch, Wine, Winetricks, and Steam's Debian installer package, depending on enabled Debian repositories and architecture.

## GPU and repository notes

- Use Debian's official documentation to configure the correct driver for your GPU. Don't install random driver scripts or mix packages from unrelated distributions.
- Some packages, notably Steam, may require Debian's `contrib` and `non-free` repository components and may not be available on every architecture.
- Check that the GPU supports the required Vulkan/OpenGL features. `vulkan-tools` provides `vulkaninfo` for diagnostics.
- Large games and compatibility layers consume significant storage. Install only the launchers and runtimes you intend to use.
- Flatpak versions of launchers are another user-controlled option, but require a configured remote and should be reviewed separately.

The script does not overclock hardware, alter kernel boot options, install proprietary drivers, or change system-wide power settings. Performance depends on hardware, drivers, and individual games.
