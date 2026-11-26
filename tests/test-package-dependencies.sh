#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

# APT must be able to resolve the complete base image, not merely find names.
mapfile -t base_packages < <(
  sed -e 's/[[:space:]]*#.*$//' -e '/^[[:space:]]*$/d' "$ROOT/config/package-lists/kinetix.list.chroot"
)
if (("${#base_packages[@]}" == 0)); then
  echo "No base packages were found." >&2
  exit 1
fi
echo "Simulating dependency resolution for ${#base_packages[@]} base packages..."
apt-get -s install --no-install-recommends "${base_packages[@]}" >/tmp/kinetix-base-apt-simulation.log

python3 - "$ROOT/config/app-bundles.yaml" <<'PY'
import subprocess
import sys
import yaml

with open(sys.argv[1], encoding="utf-8") as stream:
    config = yaml.safe_load(stream)

bundles = config.get("bundles", {})
if not bundles:
    raise SystemExit("No app bundles were found in config/app-bundles.yaml")

for name, bundle in bundles.items():
    packages = bundle.get("packages", [])
    if not packages:
        raise SystemExit(f"Bundle '{name}' has no packages")
    print(f"Simulating dependency resolution for bundle '{name}' ({len(packages)} packages)...")
    subprocess.run(
        ["apt-get", "-s", "install", "--no-install-recommends", *packages],
        check=True,
        stdout=subprocess.DEVNULL,
    )
print(f"All {len(bundles)} app bundles have resolvable dependencies.")
PY

echo "Base image and app-bundle dependency checks passed."
