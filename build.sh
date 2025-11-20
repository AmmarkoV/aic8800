#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

sudo apt-get install dkms

#Also include aic8800D80
git clone https://github.com/jeremyb31/aic8800D80.git
mv aic8800D80/aic8800D80 blobs/

sudo mkdir /lib/firmware/aic8800D80
sudo cp aic8800D80/* /lib/firmware/aic8800D80/

sudo cp -r src /usr/src/aic8800-1.0.5
sudo cp -r blobs/* /usr/lib/firmware/

sudo dkms install aic8800/1.0.5
sudo modprobe aic8800_fdrv
sudo dkms status
lsmod | grep aic8800_fdrv

sudo -i
echo 'echo ACTION=="add", ATTR{idVendor}=="a69c", ATTR{idProduct}=="5721", RUN+="/usr/sbin/usb_modeswitch -KQ -v a69c -p 5721"' >/etc/udev/rules.d/50-custom.rules


exit 0
