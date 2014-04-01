#!/bin/bash
sudo mount -t proc none kde-image/proc
sudo mount -t sysfs none kde-image/sys
sudo mount -o bind /dev kde-image/dev
sudo mount -o bind /dev/pts kde-image/dev/pts # important for pacman (for signature check)
sudo mv kde-image/etc/resolv.conf{,.pacorig}
sudo cp -L /etc/resolv.conf kde-image/etc/resolv.conf #this is needed to use networking within the chroot
sudo chroot kde-image
sudo mv kde-image/etc/resolv.conf.pacorig kde-image/etc/resolv.conf
sudo umount kde-image/dev/pts
sudo umount kde-image/dev
sudo umount kde-image/proc
sudo umount kde-image/sys
sudo umount kde-image
