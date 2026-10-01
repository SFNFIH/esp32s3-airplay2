# ESP32-S3 AirPlay 2 播放器（ESP-IDF）

用原生 **ESP-IDF ≥ 5.5**（`idf.py`）把 ESP32-S3 + PCM5102A 做成 AirPlay 2 音箱。

固件源码：[rbouteiller/airplay-esp32](https://github.com/rbouteiller/airplay-esp32)（非商业许可）。本仓库脚本已按 **纯 IDF 流程** 重构，不再依赖 PlatformIO。

## 硬件

| 零件 | 规格 |
|------|------|
| ESP32-S3 | **N16R8**（16MB Flash + 8MB PSRAM） |
| DAC | PCM5102A（3.5mm） |
| 音箱 | 接 DAC 线路输出 |

### 接线

```
ESP32-S3     PCM5102A
5V/VIN  →    VIN
GPIO11  →    BCK
GPIO12  →    DIN
GPIO13  →    LCK
GPIO14  →    GND（软件地）
GND     →    GND
```

多数板子需桥接 **VIN↔VOUT**，否则 DAC 没 5V。详见 [docs/WIRING.md](docs/WIRING.md)。

## 环境准备

```bash
# 已在本机安装示例路径（可改）
# ~/esp/esp-idf  →  ESP-IDF v5.5.2 + esp32s3 toolchain

source ./scripts/idf-env.sh
```

若尚未安装 IDF：

```bash
mkdir -p ~/esp && cd ~/esp
git clone --recursive --branch v5.5.2 https://github.com/espressif/esp-idf.git
cd esp-idf && ./install.sh esp32s3
. ./export.sh
```

## 编译 / 烧录 / 监视

```bash
make build                      # idf.py set-target + build
make flash PORT=/dev/ttyACM0    # 固件 + SPIFFS 一次烧完
make monitor PORT=/dev/ttyACM0
# 或
./scripts/build.sh
./scripts/flash-idf.sh /dev/ttyACM0
./scripts/monitor.sh /dev/ttyACM0
./scripts/menuconfig.sh         # 改 WiFi 名、引脚等
./scripts/rebuild.sh            # fullclean 后重编
```

`idf.py flash` 会同时写入 `storage`（SPIFFS Web UI），**不必**再单独 uploadfs。

默认 AirPlay 设备名：**S3 AirPlay**。配网热点连上后在 Web 页改名、音量、EQ。

## 预编译固件（可选）

不改代码时可用官方合并镜像：

```bash
./scripts/download-firmware.sh
./scripts/flash-prebuilt.sh /dev/ttyACM0   # 从 0x0 整片写入
```

浏览器刷机：https://rbouteiller.github.io/airplay-esp32/getting-started/flashing/

## 目录

```
.
├── Makefile                 # make build/flash/monitor
├── scripts/
│   ├── idf-env.sh           # source ESP-IDF
│   ├── build.sh / rebuild.sh
│   ├── flash-idf.sh / monitor.sh / menuconfig.sh
│   ├── flash-prebuilt.sh    # 官方合并 bin
│   └── download-firmware.sh
├── docs/                    # 接线 / BOM
├── firmware/                # 预编译或导出产物
└── airplay-esp32/           # ESP-IDF 工程（源码）
```

## IDF 要点

| 项 | 值 |
|----|-----|
| Target | `esp32s3` |
| SDKCONFIG_DEFAULTS | `config/sdkconfig.defaults;config/sdkconfig.defaults.esp32s3` |
| I2S | BCK=11, DO=12, WS=13, GND=14 |
| 分区 | `components/boards/partitions.csv`（含 SPIFFS `storage`） |
| 最低 IDF | 5.5 |

换板型时改 `SDKCONFIG_DEFAULTS` 第二段，例如 Waveshare：

```bash
export SDKCONFIG_DEFAULTS="config/sdkconfig.defaults;config/sdkconfig.defaults.waveshare-esp32s3"
./scripts/rebuild.sh
```

## 限制

- 仅音频；无视频
- ESP32-S3 无经典蓝牙 A2DP（仅原版 ESP32 固件带 BT）
- 上游 Non-Commercial，商用需联系原作者
