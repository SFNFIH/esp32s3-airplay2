#!/usr/bin/env bash
# menuconfig for ESP32-S3 AirPlay defaults
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# shellcheck disable=SC1091
source "${ROOT}/scripts/idf-env.sh"
cd "${AIRPLAY_ROOT}"
exec idf.py -DSDKCONFIG_DEFAULTS="${SDKCONFIG_DEFAULTS}" menuconfig
