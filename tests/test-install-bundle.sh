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

bash "$ROOT/scripts/install-bundle.sh" --list | grep -q '^productivity'
bash "$ROOT/scripts/install-bundle.sh" --dry-run productivity
grep -q -- '-s install --no-install-recommends' "$KINETIX_APT_LOG"
grep -q 'firefox-esr' "$KINETIX_APT_LOG"

if bash "$ROOT/scripts/install-bundle.sh" --dry-run does-not-exist >/dev/null 2>&1; then
  echo "Unknown bundle should have been rejected." >&2
  exit 1
fi

if bash "$ROOT/scripts/install-bundle.sh" >/dev/null 2>&1; then
  echo "Missing bundle argument should have been rejected." >&2
  exit 1
fi

echo "App bundle installer tests passed."
