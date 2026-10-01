#!/usr/bin/env bash
# Flash official prebuilt merged AirPlay2 firmware to ESP32-S3 from address 0x0
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PORT="${1:-/dev/ttyACM0}"
FW="${ROOT}/firmware/airplay2-receiver-esp32s3.bin"

if [[ ! -f "$FW" ]]; then
  echo "Missing firmware: $FW"
  echo "Download: https://github.com/rbouteiller/airplay-esp32/releases/download/v0.2.1/airplay2-receiver-esp32s3.bin"
  exit 1
fi

if ! command -v esptool.py >/dev/null 2>&1 && ! command -v esptool >/dev/null 2>&1; then
  echo "Installing esptool..."
  pip3 install --user esptool
  export PATH="${HOME}/.local/bin:${PATH}"
fi

ESPTOOL="$(command -v esptool.py || command -v esptool)"

echo "Flashing $FW -> $PORT @ 0x0"
"$ESPTOOL" --chip esp32s3 -p "$PORT" -b 921600 write_flash 0x0 "$FW"
echo "Done. Open serial monitor at 115200 baud."
