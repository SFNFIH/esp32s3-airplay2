#!/usr/bin/env bash
# Source ESP-IDF environment for this kit.
# Usage: source ./scripts/idf-env.sh
#
# Override IDF location with: export IDF_PATH=/path/to/esp-idf

_kit_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
: "${IDF_PATH:=${HOME}/esp/esp-idf}"

if [[ ! -f "${IDF_PATH}/export.sh" ]]; then
  echo "ESP-IDF not found at ${IDF_PATH}" >&2
  echo "Install: https://docs.espressif.com/projects/esp-idf/en/v5.5.2/esp32s3/get-started/" >&2
  return 1 2>/dev/null || exit 1
fi

# shellcheck disable=SC1091
source "${IDF_PATH}/export.sh"

export AIRPLAY_ROOT="${_kit_root}/airplay-esp32"
# ESP32-S3 + PCM5102A defaults (base + board)
export SDKCONFIG_DEFAULTS="config/sdkconfig.defaults;config/sdkconfig.defaults.esp32s3"

echo "IDF_PATH=${IDF_PATH}"
echo "AIRPLAY_ROOT=${AIRPLAY_ROOT}"
echo "SDKCONFIG_DEFAULTS=${SDKCONFIG_DEFAULTS}"
echo "idf.py $(idf.py --version 2>/dev/null || echo ready)"
