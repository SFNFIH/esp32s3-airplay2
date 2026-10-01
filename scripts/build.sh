#!/usr/bin/env bash
# Build AirPlay2 firmware for ESP32-S3 with native ESP-IDF (idf.py)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# shellcheck disable=SC1091
source "${ROOT}/scripts/idf-env.sh"

cd "${AIRPLAY_ROOT}"

TARGET="${IDF_TARGET:-esp32s3}"
DEFAULTS="${SDKCONFIG_DEFAULTS}"

# First-time / target change: set-target recreates sdkconfig from defaults
if [[ ! -f sdkconfig ]] || ! grep -q "CONFIG_IDF_TARGET=\"${TARGET}\"" sdkconfig 2>/dev/null; then
  echo "==> idf.py set-target ${TARGET}"
  idf.py -DSDKCONFIG_DEFAULTS="${DEFAULTS}" set-target "${TARGET}"
fi

echo "==> idf.py build (SDKCONFIG_DEFAULTS=${DEFAULTS})"
idf.py -DSDKCONFIG_DEFAULTS="${DEFAULTS}" build "$@"

echo
echo "OK. Artifacts in ${AIRPLAY_ROOT}/build/"
echo "Flash:  ./scripts/flash-idf.sh [/dev/ttyACM0]"
echo "Monitor: ./scripts/monitor.sh [/dev/ttyACM0]"
