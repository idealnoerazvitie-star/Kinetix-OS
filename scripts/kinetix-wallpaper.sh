#!/usr/bin/env bash
set -Eeuo pipefail
if ! command -v plasma-apply-wallpaperimage >/dev/null 2>&1; then
  command -v systemsettings >/dev/null 2>&1 && exec systemsettings kcm_wallpaper
  echo "KDE Plasma wallpaper tools are not installed." >&2; exit 1
fi
if command -v kdialog >/dev/null 2>&1; then
 selected="$(kdialog --title "Choose desktop wallpaper" --getopenfilename "${HOME}/Pictures" "Images (*.png *.jpg *.jpeg *.webp *.bmp *.avif *.svg)")" || exit 0
elif command -v zenity >/dev/null 2>&1; then
 selected="$(zenity --file-selection --title="Choose desktop wallpaper" --file-filter="Images | *.png *.jpg *.jpeg *.webp *.bmp *.avif *.svg")" || exit 0
else echo "Install kdialog or zenity to choose an image." >&2; exit 1; fi
[[ -n "$selected" && -f "$selected" ]] || exit 0
plasma-apply-wallpaperimage "$selected"
command -v notify-send >/dev/null 2>&1 && notify-send "Kinetix Wallpaper" "Desktop wallpaper updated." || true
