#!/usr/bin/env bash
# Fullclean + rebuild (use after target / defaults change)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# shellcheck disable=SC1091
source "${ROOT}/scripts/idf-env.sh"
cd "${AIRPLAY_ROOT}"
idf.py fullclean || true
rm -f sdkconfig sdkconfig.old
exec "${ROOT}/scripts/build.sh" "$@"
