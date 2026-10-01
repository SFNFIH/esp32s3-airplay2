#!/usr/bin/env bash
# Serial monitor via idf.py
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PORT="${1:-${ESPPORT:-/dev/ttyACM0}}"
# shellcheck disable=SC1091
source "${ROOT}/scripts/idf-env.sh"
cd "${AIRPLAY_ROOT}"
exec idf.py -p "${PORT}" monitor
