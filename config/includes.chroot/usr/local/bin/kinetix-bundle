#!/usr/bin/env bash
set -Eeuo pipefail
CONFIG_FILE="${KINETIX_BUNDLES_FILE:-/usr/share/kinetix/app-bundles.yaml}"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
if [[ ! -r "$CONFIG_FILE" && -r "$SCRIPT_DIR/../config/app-bundles.yaml" ]]; then CONFIG_FILE="$SCRIPT_DIR/../config/app-bundles.yaml"; fi
usage(){ echo "Usage: kinetix-bundle --list | [--dry-run] <bundle>"; }
[[ -r "$CONFIG_FILE" ]] || { echo "Bundle configuration not found: $CONFIG_FILE" >&2; exit 1; }
command -v python3 >/dev/null || { echo "python3 is required." >&2; exit 1; }
mode=install; bundle=""
while (($#)); do case "$1" in --help|-h) usage; exit 0;; --list) mode=list;; --dry-run) mode=dry-run;; --*) echo "Unknown option: $1" >&2; usage >&2; exit 2;; *) [[ -z "$bundle" ]] || { echo "Only one bundle may be selected." >&2; exit 2; }; bundle="$1";; esac; shift; done
if [[ "$mode" == list ]]; then
python3 - "$CONFIG_FILE" <<'PY'
import sys,yaml
with open(sys.argv[1],encoding="utf-8") as f: data=yaml.safe_load(f) or {}
for name,item in (data.get("bundles") or {}).items(): print(f"{name}\t{item.get('description','')}")
PY
exit 0; fi
[[ -n "$bundle" ]] || { usage >&2; exit 2; }
selections_file="$(mktemp)"
trap 'rm -f "$selections_file"' EXIT
python3 - "$CONFIG_FILE" "$bundle" > "$selections_file" <<'PY'
import re,sys,yaml
with open(sys.argv[1],encoding="utf-8") as f: data=yaml.safe_load(f) or {}
bundles=data.get("bundles",{}); name=sys.argv[2]
if not isinstance(bundles,dict) or name not in bundles: raise SystemExit(f"Unknown bundle '{name}'. Available: {', '.join(bundles)}")
item=bundles[name]
if not isinstance(item,dict): raise SystemExit("Bundle definition must be a mapping.")
apt=item.get("packages",[]); flatpak=item.get("flatpak",[])
if not isinstance(apt,list) or not isinstance(flatpak,list) or not apt and not flatpak: raise SystemExit("Bundle has no valid software entries.")
for p in dict.fromkeys(apt):
 if not isinstance(p,str) or not re.fullmatch(r"[a-z0-9][a-z0-9+.-]*",p): raise SystemExit(f"Invalid Debian package name: {p!r}")
 print("apt:"+p)
for app in dict.fromkeys(flatpak):
 if not isinstance(app,str) or not re.fullmatch(r"[A-Za-z0-9][A-Za-z0-9._-]*\.[A-Za-z0-9._-]+",app): raise SystemExit(f"Invalid Flatpak ID: {app!r}")
 print("flatpak:"+app)
PY
mapfile -t selections < "$selections_file"
apt_packages=(); flatpak_apps=()
for entry in "${selections[@]}"; do case "$entry" in apt:*) apt_packages+=("${entry#apt:}");; flatpak:*) flatpak_apps+=("${entry#flatpak:}");; esac; done
(("${#apt_packages[@]}"+"${#flatpak_apps[@]}" > 0)) || { echo "Bundle is empty." >&2; exit 1; }
echo "Bundle: $bundle"
(("${#apt_packages[@]}"==0)) || printf 'Debian packages: %s\n' "${apt_packages[*]}"
(("${#flatpak_apps[@]}"==0)) || printf 'Flatpak apps: %s\n' "${flatpak_apps[*]}"
if [[ "$mode" == dry-run ]]; then
 if (("${#apt_packages[@]}" > 0)); then apt-get -s install --no-install-recommends "${apt_packages[@]}"; fi
 if (("${#flatpak_apps[@]}" > 0)); then printf 'Would install from Flathub: %s\n' "${flatpak_apps[@]}"; fi
 exit 0
fi
[[ "$(id -u)" -eq 0 ]] || { echo "Run with sudo: sudo kinetix-bundle $bundle" >&2; exit 1; }
export DEBIAN_FRONTEND=noninteractive
if [[ "$bundle" == gaming ]] && printf '%s\n' "${apt_packages[@]}" | grep -qx steam-installer; then dpkg --add-architecture i386; fi
if (("${#apt_packages[@]}" > 0)); then apt-get update; apt-get install -y --no-install-recommends "${apt_packages[@]}"; fi
if (("${#flatpak_apps[@]}" > 0)); then
 command -v flatpak >/dev/null || { echo "flatpak is required." >&2; exit 1; }
 flatpak remote-add --if-not-exists --system flathub https://dl.flathub.org/repo/flathub.flatpakrepo
 flatpak install --system --noninteractive -y flathub "${flatpak_apps[@]}"
fi
echo "Kinetix bundle '$bundle' installed successfully."
