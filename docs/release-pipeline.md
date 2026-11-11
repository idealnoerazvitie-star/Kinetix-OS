# Quantix OS release pipeline

This document describes the intended release quality process for Quantix OS. A distro project should never ship an ISO without verifying that it boots, installs, and includes the expected package set.

## Goals

- build a reproducible ISO from the Debian live-build configuration
- verify the ISO boots in a virtualized environment
- validate the installer and initial desktop session
- generate checksums for official releases
- publish a clear release changelog for users

## Recommended pipeline

### 1. Build stage

Run the existing ISO build command:

```sh
sudo ./scripts/build-iso.sh
```

This should run in a Debian environment with live-build installed.

### 2. Test stage

For each ISO release, test in at least:

- QEMU
- GNOME Boxes
- VirtualBox
- real hardware if possible

Recommended checks:

- boots successfully
- network connects
- sound works
- display resolution is correct
- KDE login appears correctly
- default app bundles install or are visible
- installer launches without crashes

### 3. Smoke test checklist

After boot, validate:

- user login works
- update manager can run
- package search works
- Flatpak support is configured
- KDE settings open
- terminal opens and returns command output
- browser launches
- package installation works without dependency errors

### 4. Release metadata

Create release artifacts:

- `.iso`
- `.sha256` checksum file
- release notes
- support matrix
- supported hardware notes

### 5. GitHub release workflow

A release workflow should:

- build the ISO
- generate checksums
- upload artifacts
- create a GitHub release
- attach notes and validation status

## Suggested automation

Example workflow stages:

- `build-iso`
- `test-live-boot`
- `test-installer`
- `verify-checksum`
- `publish-release`

## Minimum quality bar

Before public release, Quantix OS should show:

- working live boot
- working installation flow
- valid package repository access
- accessible default desktop UI
- documented known limitations
- a published way to report bugs and security issues

## Implementation note

This repo already contains a build script and the live-build configuration. The next step is to formalize the release-testing process so the ISO is repeatable and can be trusted by early adopters.
