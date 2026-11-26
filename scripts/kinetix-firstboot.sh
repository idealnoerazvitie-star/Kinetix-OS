#!/usr/bin/env bash
set -Eeuo pipefail

# Kinetix first-login setup. Safe to run more than once.
USER_HOME="${HOME:?HOME must be set for the logged-in user}"
CONFIG_HOME="${XDG_CONFIG_HOME:-$USER_HOME/.config}"
STATE_DIR="$CONFIG_HOME/kinetix"
STATE_FILE="$STATE_DIR/firstboot.done"
ALIAS_FILE="$USER_HOME/.bashrc"
ALIAS_BEGIN="# >>> Kinetix OS aliases >>>"

umask 077
mkdir -p "$STATE_DIR"

if [[ -e "$STATE_FILE" ]]; then
  exit 0
fi

# Do not overwrite a profile that the user has already customized.
if [[ ! -e "$STATE_DIR/profile.conf" ]]; then
  profile_tmp="$(mktemp "$STATE_DIR/profile.conf.XXXXXX")"
  cat > "$profile_tmp" <<'EOF'
PROFILE=default
THEME=kinetix
TERMINAL=konsole
SHELL_PROMPT=default
EOF
  mv -- "$profile_tmp" "$STATE_DIR/profile.conf"
fi

# Add the aliases once, without duplicating them on a manual re-run.
if [[ ! -f "$ALIAS_FILE" ]]; then
  touch "$ALIAS_FILE"
fi
if ! grep -Fq "$ALIAS_BEGIN" "$ALIAS_FILE"; then
  cat >> "$ALIAS_FILE" <<'EOF'

# >>> Kinetix OS aliases >>>
alias ll='ls -la'
alias la='ls -A'
alias update='sudo apt update && sudo apt upgrade'
alias clean='sudo apt autoremove --purge'
alias search='grep -R --color=auto'
# <<< Kinetix OS aliases <<<
EOF
fi

# These are optional desktop niceties; their absence must not break setup.
if command -v fastfetch >/dev/null 2>&1; then
  fastfetch --config none >/dev/null 2>&1 || true
fi
if command -v notify-send >/dev/null 2>&1; then
  notify-send "Kinetix OS" "Welcome! Your desktop is ready." >/dev/null 2>&1 || true
fi

# Mark completion only after all required setup steps have succeeded.
touch "$STATE_FILE"
printf 'Kinetix first-login setup completed.\n'
