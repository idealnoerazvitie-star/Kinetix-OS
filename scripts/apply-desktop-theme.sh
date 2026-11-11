#!/usr/bin/env bash
set -eu

# Quantix OS desktop theme helper
# Provides a basic KDE Plasma theme setup for the Quantix white-and-blue identity.

ICON_THEME="breeze"
COLOR_SCHEME="BreezeLight"
KDE_THEME="Breeze"

mkdir -p "${HOME}/.config"

cat > "${HOME}/.config/quantix-kde.conf" <<EOF
[Desktop]
Theme=Breeze
ColorScheme=BreezeLight
AccentColor=#2878e8
Wallpaper=quantix-default
IconTheme=breeze
EOF

printf 'Quantix KDE defaults configuration written to %s/.config/quantix-kde.conf\n' "${HOME}"
printf 'Apply the theme manually in KDE System Settings if the defaults are not automatically detected.\n'
