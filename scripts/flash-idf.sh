#!/usr/bin/env bash
# Flash firmware + SPIFFS via idf.py (ESP32-S3)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PORT="${1:-${ESPPORT:-/dev/ttyACM0}}"
# shellcheck disable=SC1091
source "${ROOT}/scripts/idf-env.sh"

cd "${AIRPLAY_ROOT}"

if [[ ! -f build/airplay2-receiver.bin ]]; then
  echo "No build yet — running ./scripts/build.sh"
  "${ROOT}/scripts/build.sh"
fi

echo "==> idf.py -p ${PORT} flash"
idf.py -p "${PORT}" -DSDKCONFIG_DEFAULTS="${SDKCONFIG_DEFAULTS}" flash
echo "Done. Run: ./scripts/monitor.sh ${PORT}"
