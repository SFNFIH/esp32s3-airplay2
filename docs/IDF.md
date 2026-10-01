# ESP-IDF 构建说明

本套件以 **ESP-IDF** 为唯一一等构建系统。

## 一键流程

```bash
source ./scripts/idf-env.sh   # 或依赖脚本内部自动 source
make rebuild                  # 干净配置 + 编译 esp32s3
make flash PORT=/dev/ttyACM0
make monitor PORT=/dev/ttyACM0
```

## 等价纯手工命令

```bash
source ~/esp/esp-idf/export.sh
cd airplay-esp32

idf.py -DSDKCONFIG_DEFAULTS="config/sdkconfig.defaults;config/sdkconfig.defaults.esp32s3" \
  set-target esp32s3

idf.py -DSDKCONFIG_DEFAULTS="config/sdkconfig.defaults;config/sdkconfig.defaults.esp32s3" \
  build

idf.py -p /dev/ttyACM0 flash monitor
```

## 产物位置

编译后在 `airplay-esp32/build/`：

- `airplay2-receiver.bin` — 应用
- `bootloader/bootloader.bin`
- `partition_table/partition-table.bin`
- `storage.bin` — SPIFFS（Web UI）
- `flasher_args.json` — `idf.py flash` 用的地址表

导出到套件目录：

```bash
./scripts/export-build.sh
```

## 与 PlatformIO 的关系

上游仓库仍带 `platformio.ini`，但本套件脚本与文档**不再调用 PIO**。
请用 `idf.py`，这样 `flash` 会连同 SPIFFS 一起写入。
