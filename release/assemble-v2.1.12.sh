#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ARCHIVE="$SCRIPT_DIR/dimasdptopology-v2.1.12.tar.gz"
TMP="$ARCHIVE.tmp"
EXPECTED_SHA256="799038066800120ec18ca4650f5126f8d2c8b0a1048dd32044a478e110c92781"

trap 'rm -f "$TMP"' EXIT
command -v base64 >/dev/null 2>&1 || { echo "ERROR: base64 is required" >&2; exit 1; }
command -v sha256sum >/dev/null 2>&1 || { echo "ERROR: sha256sum is required" >&2; exit 1; }
command -v tar >/dev/null 2>&1 || { echo "ERROR: tar is required" >&2; exit 1; }

cat \
  "$SCRIPT_DIR/dimasdptopology-v2.1.12.tar.gz.b64.part-01" \
  "$SCRIPT_DIR/dimasdptopology-v2.1.12.tar.gz.b64.part-02" \
  "$SCRIPT_DIR/dimasdptopology-v2.1.12.tar.gz.b64.part-03" \
  "$SCRIPT_DIR/dimasdptopology-v2.1.12.tar.gz.b64.part-04" \
  "$SCRIPT_DIR/dimasdptopology-v2.1.12.tar.gz.b64.part-05" \
  "$SCRIPT_DIR/dimasdptopology-v2.1.12.tar.gz.b64.part-06" \
  "$SCRIPT_DIR/dimasdptopology-v2.1.12.tar.gz.b64.part-07" \
  | base64 --decode > "$TMP"

ACTUAL_SHA256="$(sha256sum "$TMP" | awk '{print $1}')"
if [[ "$ACTUAL_SHA256" != "$EXPECTED_SHA256" ]]; then
  echo "ERROR: SHA-256 mismatch" >&2
  echo "Expected: $EXPECTED_SHA256" >&2
  echo "Actual:   $ACTUAL_SHA256" >&2
  exit 2
fi

tar -tzf "$TMP" >/dev/null
mv -f "$TMP" "$ARCHIVE"
trap - EXIT
echo "Archive reconstructed and verified:"
echo "$ARCHIVE"
echo "SHA-256: $ACTUAL_SHA256"
