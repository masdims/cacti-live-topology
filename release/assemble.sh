#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ARCHIVE="$SCRIPT_DIR/dimasdptopology-public-v2.1.11.tar.gz"
TMP="$ARCHIVE.tmp"
EXPECTED_SHA256="12e60c8b8a7ba433ffec5f11f23f78c58c590c8add6e179604509b95efb12e6b"

command -v base64 >/dev/null 2>&1 || { echo "ERROR: base64 is required" >&2; exit 1; }
command -v sha256sum >/dev/null 2>&1 || { echo "ERROR: sha256sum is required" >&2; exit 1; }
command -v tar >/dev/null 2>&1 || { echo "ERROR: tar is required" >&2; exit 1; }

shopt -s nullglob
rest_parts=("$SCRIPT_DIR"/dimasdptopology-public-v2.1.11.tar.gz.b64.rest-*)
shopt -u nullglob
if (( ${#rest_parts[@]} != 15 )); then
  echo "ERROR: expected 15 rest segments, found ${#rest_parts[@]}" >&2
  exit 2
fi

{
  cat "$SCRIPT_DIR/dimasdptopology-public-v2.1.11.tar.gz.b64.part-00"
  cat "$SCRIPT_DIR/dimasdptopology-public-v2.1.11.tar.gz.b64.part-01"
  cat "${rest_parts[@]}"
} | base64 --decode > "$TMP"

ACTUAL_SHA256="$(sha256sum "$TMP" | awk '{print $1}')"
if [[ "$ACTUAL_SHA256" != "$EXPECTED_SHA256" ]]; then
  rm -f "$TMP"
  echo "ERROR: SHA-256 mismatch" >&2
  echo "Expected: $EXPECTED_SHA256" >&2
  echo "Actual:   $ACTUAL_SHA256" >&2
  exit 3
fi

tar -tzf "$TMP" >/dev/null
mv -f "$TMP" "$ARCHIVE"
echo "Archive reconstructed and verified:"
echo "$ARCHIVE"
echo "SHA-256: $ACTUAL_SHA256"
