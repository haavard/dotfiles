#!/usr/bin/env sh
set -o errexit

cd "$(dirname "$0")"
rm -rf dwm
git clone --depth=1 https://git.suckless.org/dwm
cd dwm
cp ../config.h .
make

