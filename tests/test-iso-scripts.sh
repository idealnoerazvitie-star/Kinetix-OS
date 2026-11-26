#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
bash -n "$ROOT/scripts/verify-iso.sh"
bash -n "$ROOT/scripts/hardware-report.sh"
git -C "$ROOT" check-ignore -q dist/Kinetix-OS-amd64.iso
git -C "$ROOT" check-ignore -q binary/live-image-amd64.hybrid.iso

set +e
bash "$ROOT/scripts/verify-iso.sh" >/dev/null 2>&1
status=$?
set -e
if [[ "$status" -ne 2 ]]; then
  echo "verify-iso.sh must return usage status 2 when no ISO is supplied (got $status)." >&2
  exit 1
fi

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
bash "$ROOT/scripts/hardware-report.sh" "$tmp"
grep -q "read-only inventory" "$tmp"
echo "ISO helper syntax and hardware-report smoke tests passed."
