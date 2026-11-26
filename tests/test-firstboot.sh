#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_HOME="$(mktemp -d)"
trap 'rm -rf "$TMP_HOME"' EXIT

export HOME="$TMP_HOME/home"
export XDG_CONFIG_HOME="$TMP_HOME/config"
mkdir -p "$HOME" "$XDG_CONFIG_HOME"
SCRIPT="$ROOT/scripts/kinetix-firstboot.sh"

bash "$SCRIPT"
[[ -f "$XDG_CONFIG_HOME/kinetix/firstboot.done" ]]
[[ -f "$XDG_CONFIG_HOME/kinetix/profile.conf" ]]
[[ -f "$HOME/.bashrc" ]]
[[ "$(grep -Fc '# >>> Kinetix OS aliases >>>' "$HOME/.bashrc")" -eq 1 ]]

# Re-running the script must not duplicate aliases or overwrite user settings.
printf 'PROFILE=custom\n' > "$XDG_CONFIG_HOME/kinetix/profile.conf"
rm "$XDG_CONFIG_HOME/kinetix/firstboot.done"
bash "$SCRIPT"
[[ "$(grep -Fc '# >>> Kinetix OS aliases >>>' "$HOME/.bashrc")" -eq 1 ]]
grep -Fxq 'PROFILE=custom' "$XDG_CONFIG_HOME/kinetix/profile.conf"

echo "First-login setup tests passed."
