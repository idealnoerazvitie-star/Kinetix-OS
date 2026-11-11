#!/usr/bin/env bash
set -eu

# Quantix first-boot helper
# Intended for use on the live desktop or the installed system.
# It runs once per user and prepares a friendly starting environment.

USER_HOME="${HOME:-/root}"
STATE_DIR="${USER_HOME}/.config/quantix"
STATE_FILE="${STATE_DIR}/firstboot.done"
ALIAS_FILE="${USER_HOME}/.bashrc"

mkdir -p "${STATE_DIR}"

if [ -f "${STATE_FILE}" ]; then
  exit 0
fi

cat > "${STATE_DIR}/profile.conf" <<'EOF'
PROFILE=default
THEME=quantix
TERMINAL=konsole
SHELL_PROMPT=default
EOF

cat >> "${ALIAS_FILE}" <<'EOF'
# Quantix OS aliases
alias ll='ls -la'
alias la='ls -A'
alias update='sudo apt update && sudo apt upgrade'
alias clean='sudo apt autoremove --purge'
alias search='grep -R --color=auto'
EOF

if command -v fastfetch >/dev/null 2>&1; then
  fastfetch --config none >/dev/null 2>&1 || true
fi

if command -v notify-send >/dev/null 2>&1; then
  notify-send "Quantix OS" "Welcome! Your desktop is ready."
fi

touch "${STATE_FILE}"

printf 'Quantix first-boot setup completed.\n'
