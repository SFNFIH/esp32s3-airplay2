# ESP32-S3 AirPlay 2 — native ESP-IDF workflow
# Usage: make build | flash | monitor | menuconfig | rebuild
# Optional: make flash PORT=/dev/ttyUSB0

ROOT := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
PORT ?= /dev/ttyACM0
export ESPPORT := $(PORT)

.PHONY: env build flash monitor menuconfig rebuild clean download-fw flash-prebuilt export

env:
	@echo "Run: source ./scripts/idf-env.sh"

build:
	$(ROOT)/scripts/build.sh

flash:
	$(ROOT)/scripts/flash-idf.sh $(PORT)

monitor:
	$(ROOT)/scripts/monitor.sh $(PORT)

menuconfig:
	$(ROOT)/scripts/menuconfig.sh

rebuild:
	$(ROOT)/scripts/rebuild.sh

export:
	$(ROOT)/scripts/export-build.sh

clean:
	. $(ROOT)/scripts/idf-env.sh && cd $(ROOT)/airplay-esp32 && idf.py fullclean

download-fw:
	$(ROOT)/scripts/download-firmware.sh

flash-prebuilt:
	$(ROOT)/scripts/flash-prebuilt.sh $(PORT)
