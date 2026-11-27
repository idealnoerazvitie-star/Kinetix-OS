#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

export KINETIX_BUNDLES_FILE="$ROOT/config/app-bundles.yaml"
export KINETIX_APT_LOG="$TMP/apt.log"

mkdir -p "$TMP/bin"
cat > "$TMP/bin/apt-get" <<'EOF'
#!/usr/bin/env bash
printf '%s\n' "$*" >> "$KINETIX_APT_LOG"
EOF
chmod +x "$TMP/bin/apt-get"
export PATH="$TMP/bin:$PATH"

bash "$ROOT/scripts/install-bundle.sh" --list > "$TMP/bundles.txt"
grep -q '^gaming$' "$TMP/bundles.txt"

bash "$ROOT/scripts/install-bundle.sh" --dry-run productivity > "$TMP/productivity.txt"
grep -q -- '-s install --no-install-recommends' "$KINETIX_APT_LOG"
grep -q 'libreoffice-writer' "$KINETIX_APT_LOG"

bash "$ROOT/scripts/install-bundle.sh" --dry-run gaming > "$TMP/gaming.txt"
grep -q 'com.heroicgameslauncher.hgl' "$TMP/gaming.txt"

if bash "$ROOT/scripts/install-bundle.sh" --dry-run unknown > /dev/null 2>&1; then
  echo "Unknown bundle was accepted." >&2
  exit 1
fi

if bash "$ROOT/scripts/install-bundle.sh" > /dev/null 2>&1; then
  echo "Missing bundle was accepted." >&2
  exit 1
fi

echo "Kinetix app bundle tests passed."
