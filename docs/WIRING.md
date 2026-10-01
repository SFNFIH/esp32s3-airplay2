# 接线与排障

## 推荐接法（直插母排）

把 6P 母排插在 ESP32-S3 的 **GPIO11–14 一侧**（含旁边的 5V），再把 PCM5102A 插上去：

| ESP32-S3 | PCM5102A | 作用 |
|----------|----------|------|
| 5V | VIN | DAC 供电 |
| GPIO11 | BCK | 位时钟 ≈ 1.41 MHz @ 44.1k |
| GPIO12 | DIN | 音频数据 |
| GPIO13 | LCK | 左右声道选择 |
| GPIO14 | GND | 固件软件地 |
| GND | GND | 系统地（推荐） |

MCLK 可不接：PCM5102A 内部可自生成。若要用其他 codec，默认 MCLK 在 **GPIO8**。

## 常见板型变体

### Waveshare ESP32-S3 音视频板

用环境 `waveshare-esp32s3`，引脚不同（BCK=9, WS=10, DO=12）。

### 只有 8MB Flash

可改 `platformio.ini` 里 `board_build.flash_size`，或刷对应预编译包。默认镜像按 **16MB** 分区表做的，8MB 板请自行编译。

### MAX98357A 功放模块

I2S 同样三线（BCLK/LRCLK/DIN），接法类似；注意该芯片是功放输出，直接接喇叭，不要当线路输出。需改板级配置或 menuconfig。

## 串口日志关键词

```text
WiFi connected
mDNS hostname: ...
AirPlay device ready
```

出现后，同一局域网的 iOS/macOS 应能发现设备。

## WiFi 发现不了

- 手机与 ESP32 必须同一网段，关闭「AP 隔离 / 访客网络」。
- 公司/宾馆门户认证网络通常不行。
- 尽量用 5GHz 或干净的 2.4GHz；干扰大时会卡顿。
- 重置：擦 NVS 或长按复位后重新配网（见上游文档）。

## 音质提示

- 默认 I2S 16-bit / 44.1 kHz stereo。
- Web 页可调音量与 EQ。
- 可选用 44.1→48 kHz sinc 重采样（menuconfig）。
