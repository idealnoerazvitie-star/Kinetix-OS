#!/usr/bin/env bash
set -euo pipefail

# Optional gaming utilities. Packages are installed only when requested and
# available from the system's configured Debian repositories.
GROUP="${1:-runtime}"

if ! command -v apt-get >/dev/null 2>&1; then
  echo "This script requires a Debian-based system with apt-get." >&2
  exit 1
fi

case "$GROUP" in
  runtime)
    REQUESTED=(gamemode mangohud gamescope vulkan-tools mesa-utils)
    ;;
  launchers)
    REQUESTED=(lutris retroarch wine winetricks steam-installer)
    ;;
  all)
    REQUESTED=(gamemode mangohud gamescope vulkan-tools mesa-utils lutris retroarch wine winetricks steam-installer)
    ;;
  *)
    echo "Usage: $0 [runtime|launchers|all]" >&2
    exit 2
    ;;
esac

if [[ "${EUID}" -eq 0 ]]; then
  APT=(apt-get)
else
  if ! command -v sudo >/dev/null 2>&1; then
    echo "Run as root or install sudo." >&2
    exit 1
  fi
  APT=(sudo apt-get)
fi

"${APT[@]}" update
AVAILABLE=()
for package in "${REQUESTED[@]}"; do
  if apt-cache show "$package" >/dev/null 2>&1; then
    AVAILABLE+=("$package")
  else
    echo "Skipping $package: not available in configured repositories for this system."
  fi
done

if ((${#AVAILABLE[@]} == 0)); then
  echo "No requested gaming packages were found. Check Debian repository components and architecture." >&2
  exit 1
fi

"${APT[@]}" install -y --no-install-recommends "${AVAILABLE[@]}"
printf '\nInstalled available packages in the %s gaming group: %s\n' "$GROUP" "${AVAILABLE[*]}"
echo "GPU drivers are not changed by this script. See docs/gaming-features.md."
