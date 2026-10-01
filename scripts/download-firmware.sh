#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "${ROOT}/firmware"
URL="https://github.com/rbouteiller/airplay-esp32/releases/download/v0.2.1/airplay2-receiver-esp32s3.bin"
OUT="${ROOT}/firmware/airplay2-receiver-esp32s3.bin"
curl -L -o "$OUT" "$URL"
sha256sum "$OUT"
echo "Expected sha256: 3be6800d000a2508293a14858925c53a0ffcc88f9aac3fa96430068373cb6773"
