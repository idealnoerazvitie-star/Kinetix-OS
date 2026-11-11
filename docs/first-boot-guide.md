# Quantix OS first-boot guide

This guide describes the intended first-run experience for Quantix OS. The purpose is to make the distribution welcoming, modern, and easy for new Linux users while still giving more advanced users direct control from the terminal.

## Goals

- guide the user through localization and account setup
- recommend the correct system update flow
- let the user choose a default usage profile
- show a simple, readable welcome screen after installation
- avoid overwhelming the user with too many options at once

## Expected first-run flow

When the user logs in for the first time, Quantix should open a welcome screen with the following steps:

1. Choose language and keyboard layout
2. Select timezone
3. Set a username and password
4. Decide whether to use:
   - Productivity
   - Developer
   - Maker
   - Security Learning
   - Gaming
   - Accessibility
5. Optional: install recommended updates
6. Optional: install extra app bundles and drivers
7. Finish and open the desktop

## Recommended behavior

A helper script such as `scripts/quantix-firstboot.sh` should create a one-time state file so the welcome screen appears only once.

The process should:

- check if the user is on first login
- show a non-intrusive welcome modal or app window
- allow a user to accept defaults or skip the wizard
- offer an "Install recommended software" option

## Suggested welcome text

Welcome to Quantix OS.

This desktop is built for a clean, modern Linux experience.

Choose the setup that best matches how you use your computer:

- Productivity: Office, web, media, and daily tasks
- Developer: Shell tools, programming, containers, and source control
- Maker: Electronics, coding, and learning projects
- Security Learning: Networking, digital forensics, and lab tools
- Gaming: entertainment and desktop gameplay
- Accessibility: assistive tools and usability helpers

## Recommended defaults

- `Locale`: system default or English (US)
- `Keyboard`: user locale default
- `Theme`: Quantix white/blue KDE theme
- `Software manager`: Debian APT + Flatpak
- `Updates`: enabled by default

## Post-install checklist

- update package cache
- install recommended apps
- confirm KDE Plasma settings are applied
- verify network is working
- confirm audio and printer support are available

## Implementation notes

The repository includes a first-boot helper at `scripts/quantix-firstboot.sh`. This should be launched from the desktop autostart config or from the user's startup session on the first login.

The script is expected to:

- create a `.config/quantix` directory
- write a state marker after first-run completion
- append shell aliases for common tasks
- optionally notify the user that setup is complete
