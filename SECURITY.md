# Security Policy

## Project status

Kinetix OS is an early-stage Debian live-build scaffold (see the "Current
limitations" section of [README.md](README.md)). There are no tagged
releases, no signed ISO builds, and no published images yet — everything
in this repository is build configuration and source files, not a
distributed binary. The version table that is normally expected in this
file does not apply yet: there is nothing released to carry a security
fix to.

Once signed ISO releases exist, this section will list which release
lines receive security updates.

## Reporting a vulnerability

If you find a security issue in this repository's build configuration,
scripts, or first-boot tooling (for example, something in
`config/includes.chroot/`, `scripts/`, or `auto/config` that could let a
built image boot insecurely, leak credentials, or run unintended code),
please report it privately rather than opening a public issue:

- Use GitHub's **Security Advisories** feature for this repository
  ("Security" tab → "Report a vulnerability"). This opens a private
  report visible only to the maintainers until a fix is ready.
- If advisories are not enabled for this repository, open a regular
  issue asking a maintainer to enable them, without including
  vulnerability details in that issue.

Please do not report vulnerabilities in the upstream packages this
project pulls in (KDE Plasma, Debian packages, Flatpak apps, etc.) here
— report those to the relevant upstream project or to the
[Debian Security Team](https://www.debian.org/security/).

There is currently no dedicated security contact email or bug-bounty
program for this project.
