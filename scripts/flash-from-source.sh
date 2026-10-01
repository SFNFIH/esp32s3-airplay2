#!/usr/bin/env bash
# Flash locally built ESP32-S3 firmware pieces (app + SPIFFS web UI)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PORT="${1:-/dev/ttyACM0}"
DIR="${ROOT}/firmware/from-source"
export PATH="${HOME}/.local/bin:${PATH}"

ESPTOOL="$(command -v esptool.py || command -v esptool || true)"
if [[ -z "$ESPTOOL" ]]; then
  pip3 install --user esptool
  ESPTOOL="$(command -v esptool.py || command -v esptool)"
fi

for f in bootloader.bin partitions.bin ota_data_initial.bin airplay2-app-esp32s3.bin spiffs.bin; do
  [[ -f "$DIR/$f" ]] || { echo "Missing $DIR/$f — run ./scripts/build.sh first"; exit 1; }
done

echo "Flashing from-source images to $PORT"
"$ESPTOOL" --chip esp32s3 -p "$PORT" -b 921600 write_flash \
  0x0       "$DIR/bootloader.bin" \
  0x8000    "$DIR/partitions.bin" \
  0x19000   "$DIR/ota_data_initial.bin" \
  0x20000   "$DIR/airplay2-app-esp32s3.bin" \
  0x620000  "$DIR/spiffs.bin"

echo "Done."
