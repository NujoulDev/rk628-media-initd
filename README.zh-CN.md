# RK628 media-initd

[English](README.md) | **简体中文**

在 Raspberry Pi OS 上，等待 HDMI 信号稳定后，自动配置 RK628 的视频分辨率、像素格式和采集链路。每次启动服务只配置一次。

## 安装

先按 [RK628 驱动安装指南](https://github.com/NujoulDev/rk628-rpi-driver/blob/main/README.zh-CN.md#驱动安装) 安装 `rk628-rpi-dkms`、配置 overlay 并重启。选择下面任意一种方式安装 media-initd。

### 从 .deb 安装

从 [最新 Release](https://github.com/NujoulDev/rk628-media-initd/releases/latest) 下载 `.deb`。在下载目录执行以下命令，把 `PACKAGE.deb` 换成实际文件名。

```bash
sudo apt install ./PACKAGE.deb
```

### 从源码安装

先安装打包依赖。

```bash
sudo apt update
sudo apt install git build-essential dpkg-dev debhelper
```

下载源码并打包。

```bash
git clone https://github.com/NujoulDev/rk628-media-initd.git
cd rk628-media-initd
dpkg-buildpackage -us -uc -b
```

生成的 `.deb` 在源码目录的上一级。在源码目录执行以下命令安装。

```bash
sudo apt install "../rk628-media-initd_$(dpkg-parsechangelog -S Version)_all.deb"
```

## 检查服务

安装完成后，服务会自动启动，以后也会随系统启动。接入 HDMI 信号源后，查看状态和本次开机的日志。

```bash
systemctl status rk628-media-initd.service
sudo journalctl -u rk628-media-initd.service -b
```

日志出现 `Ready:` 表示采集配置完成。下面是 1080p 输入的示例。

```text
Ready: /dev/rk628-video 1920x1080 UYVY
```

如果服务一直等待，确认 HDMI 源正在输出，并用 `ls -l /dev/rk628-*` 检查驱动是否已创建设备节点。

## 重新配置

切换 HDMI 信号源或更改输入分辨率后，先停止采集程序，再重启服务。等日志再次出现 `Ready:`，就可以继续采集。

```bash
sudo systemctl restart rk628-media-initd.service
```

## 卸载

```bash
sudo apt purge rk628-media-initd
```
