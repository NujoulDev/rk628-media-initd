#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
set -eu

die() { echo "Error: $*" >&2; exit 1; }

if [ "${1:-}" = --help ] || [ "${1:-}" = -h ]; then
  echo "Usage: sudo sh media-initd.sh"
  echo "Detect Raspberry Pi 4 or 5 and initialize capture"
  exit 0
fi
[ "$#" -eq 0 ] || die "Unexpected argument: $1"
[ -r /proc/device-tree/model ] || die "Cannot read board model from device tree"

model=$(tr -d '\000' < /proc/device-tree/model)
case "$model" in
  "Raspberry Pi 4 "*) platform=pi4 ;;
  "Raspberry Pi 5 "*) platform=pi5 ;;
  *) die "Unsupported board: $model" ;;
esac

SCRIPT_DIR=$(CDPATH='' cd "$(dirname "$0")" && pwd)
exec /bin/sh "$SCRIPT_DIR/media-initd-$platform.sh"
