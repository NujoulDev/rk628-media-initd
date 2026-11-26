# RK628 media-initd

Configures RK628 video capture once after the first stable HDMI signal.
Requires Raspberry Pi OS and the `rk628-rpi-dkms` driver package with its
overlay configured.

## Install

### From Release

Download the `.deb` from the [latest Release](https://github.com/NujoulDev/rk628-media-initd/releases/latest). In the download directory, replace `PACKAGE.deb` with the downloaded filename and run:

```bash
sudo apt install ./PACKAGE.deb
```

### From source

Install the build dependencies:

```bash
sudo apt install git build-essential dpkg-dev debhelper
```

Clone the repository and build the package:

```bash
git clone https://github.com/NujoulDev/rk628-media-initd.git
cd rk628-media-initd
dpkg-buildpackage -us -uc -b
```

The build writes the package to the parent directory. Run this from the source directory:

```bash
sudo apt install "../rk628-media-initd_$(dpkg-parsechangelog -S Version)_all.deb"
```

### Check the service

```bash
systemctl status rk628-media-initd.service
```

The service starts automatically after installation and at boot.

After changing the HDMI source or resolution, stop capture applications and run:

```bash
sudo systemctl restart rk628-media-initd.service
```

View initialization logs with:

```bash
journalctl -u rk628-media-initd.service -b
```

## Uninstall

```bash
sudo apt purge rk628-media-initd
```
