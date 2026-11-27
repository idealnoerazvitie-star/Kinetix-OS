#!/usr/bin/env bash
set -Eeuo pipefail

CONFIG_FILE="${KINETIX_BUNDLES_FILE:-/usr/share/kinetix/app-bundles.yaml}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
if [[ ! -r "$CONFIG_FILE" && -r "$SCRIPT_DIR/../config/app-bundles.yaml" ]]; then
  CONFIG_FILE="$SCRIPT_DIR/../config/app-bundles.yaml"
fi

usage() {
  cat <<'EOF'
Kinetix optional app bundle installer

Usage:
  kinetix-bundle --list
  kinetix-bundle [--dry-run] <bundle>

Options:
  --list       List available bundles
  --dry-run    Simulate package installation without changing the system
  --help       Show this help

Examples:
  kinetix-bundle --list
  sudo kinetix-bundle productivity
  kinetix-bundle --dry-run developer
EOF
}

if [[ ! -r "$CONFIG_FILE" ]]; then
  echo "Bundle configuration not found: $CONFIG_FILE" >&2
  exit 1
fi
command -v python3 >/dev/null 2>&1 || { echo "python3 is required." >&2; exit 1; }

mode="install"
bundle=""
while (($#)); do
  case "$1" in
    --help|-h) usage; exit 0 ;;
    --list) mode="list" ;;
    --dry-run) mode="dry-run" ;;
    --*) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
    *)
      if [[ -n "$bundle" ]]; then echo "Only one bundle can be installed at a time." >&2; exit 2; fi
      bundle="$1"
      ;;
  esac
  shift
done

if [[ "$mode" == "list" ]]; then
  python3 - "$CONFIG_FILE" <<'PY'
import sys
import yaml

with open(sys.argv[1], encoding="utf-8") as stream:
    config = yaml.safe_load(stream) or {}
bundles = config.get("bundles", {})
if not isinstance(bundles, dict) or not bundles:
    raise SystemExit("No bundles are defined in the configuration.")
for name, details in bundles.items():
    description = details.get("description", "") if isinstance(details, dict) else ""
    print(f"{name}\t{description}")
PY
  exit 0
fi

if [[ -z "$bundle" ]]; then usage >&2; exit 2; fi

packages="$(python3 - "$CONFIG_FILE" "$bundle" <<'PY'
import re
import sys
import yaml

with open(sys.argv[1], encoding="utf-8") as stream:
    config = yaml.safe_load(stream) or {}
bundles = config.get("bundles", {})
name = sys.argv[2]
if not isinstance(bundles, dict) or name not in bundles:
    available = ", ".join(bundles) if isinstance(bundles, dict) else "(none)"
    raise SystemExit(f"Unknown bundle '{name}'. Available bundles: {available}")
details = bundles[name]
if not isinstance(details, dict):
    raise SystemExit(f"Bundle '{name}' must be a mapping.")
items = details.get("packages", [])
if not isinstance(items, list) or not items:
    raise SystemExit(f"Bundle '{name}' has no packages.")
seen = set()
for item in items:
    if not isinstance(item, str) or not re.fullmatch(r"[a-z0-9][a-z0-9+.-]*", item):
        raise SystemExit(f"Invalid package name in bundle '{name}': {item!r}")
    if item not in seen:
        print(item)
        seen.add(item)
PY
)"
mapfile -t package_list <<< "$packages"
if (("${#package_list[@]}" == 0)) || [[ -z "${package_list[0]}" ]]; then
  echo "Bundle '$bundle' resolved to an empty package list." >&2
  exit 1
fi

echo "Bundle: $bundle"
printf 'Packages: %s\n' "${package_list[*]}"

if [[ "$mode" == "dry-run" ]]; then
  command -v apt-get >/dev/null 2>&1 || { echo "apt-get is required." >&2; exit 1; }
  exec apt-get -s install --no-install-recommends "${package_list[@]}"
fi

if [[ "$(id -u)" -ne 0 ]]; then
  echo "Administrator privileges are required. Run: sudo kinetix-bundle $bundle" >&2
  exit 1
fi
command -v apt-get >/dev/null 2>&1 || { echo "apt-get is required." >&2; exit 1; }

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends "${package_list[@]}"
echo "Kinetix bundle '$bundle' installed successfully."
