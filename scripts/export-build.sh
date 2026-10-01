#!/usr/bin/env bash
# Copy IDF build artifacts into firmware/from-idf/
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="${ROOT}/airplay-esp32/build"
DST="${ROOT}/firmware/from-idf"
mkdir -p "${DST}"

[[ -f "${SRC}/airplay2-receiver.bin" ]] || {
  echo "Build missing — run ./scripts/build.sh first" >&2
  exit 1
}

cp -v "${SRC}/airplay2-receiver.bin" "${DST}/"
cp -v "${SRC}/bootloader/bootloader.bin" "${DST}/"
cp -v "${SRC}/partition_table/partition-table.bin" "${DST}/"
cp -v "${SRC}/ota_data_initial.bin" "${DST}/" 2>/dev/null || true
cp -v "${SRC}/storage.bin" "${DST}/" 2>/dev/null || true
cp -v "${SRC}/flasher_args.json" "${DST}/" 2>/dev/null || true

echo "Exported to ${DST}"
ls -lh "${DST}"
