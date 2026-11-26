# RK628 media-initd

**English** | [简体中文](README.zh-CN.md)

On Raspberry Pi OS, media-initd waits for a stable HDMI signal and configures the RK628 video resolution, pixel format, and capture pipeline once each time the service starts.

## Install

Follow the [RK628 driver installation guide](https://github.com/NujoulDev/rk628-rpi-driver/blob/main/README.md#driver-installation) to install `rk628-rpi-dkms`, configure the overlay, and reboot. Then choose either method below to install media-initd.

### From a .deb

Download the `.deb` from the [latest Release](https://github.com/NujoulDev/rk628-media-initd/releases/latest). In the download directory, replace `PACKAGE.deb` with the downloaded filename and run this command.

```bash
sudo apt install ./PACKAGE.deb
```

### From source

Install the build dependencies.

```bash
sudo apt update
sudo apt install git build-essential dpkg-dev debhelper
```

Clone the repository and build the package.

```bash
git clone https://github.com/NujoulDev/rk628-media-initd.git
cd rk628-media-initd
dpkg-buildpackage -us -uc -b
```

The package is built in the parent directory. Run this command from the source directory.

```bash
sudo apt install "../rk628-media-initd_$(dpkg-parsechangelog -S Version)_all.deb"
```

## Check the service

The service starts automatically after installation and at boot. Connect an HDMI source, then check the service status and the logs for the current boot.

```bash
systemctl status rk628-media-initd.service
sudo journalctl -u rk628-media-initd.service -b
```

A `Ready:` message indicates that capture is configured. For a 1080p input, it looks like this.

```text
Ready: /dev/rk628-video 1920x1080 UYVY
```

If the service keeps waiting, check that the HDMI source is active and use `ls -l /dev/rk628-*` to check that the driver has created its device nodes.

## Reconfigure capture

After switching HDMI sources or changing the input resolution, stop the capture application and restart the service. Resume capture once `Ready:` appears in the log again.

```bash
sudo systemctl restart rk628-media-initd.service
```

## Uninstall

```bash
sudo apt purge rk628-media-initd
```
