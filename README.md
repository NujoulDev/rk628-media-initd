# RK628 media-initd

Configures RK628 video capture once after the first stable HDMI signal.
Requires Raspberry Pi OS and the `rk628-rpi-dkms` driver package with its
overlay configured.

## Build

```bash
sudo apt install build-essential dpkg-dev debhelper
dpkg-buildpackage -us -uc -b
```

The package is generated in the parent directory.

## Install

```bash
sudo apt install ./rk628-media-initd_0.1.0-1_all.deb
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
