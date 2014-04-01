#!/bin/bash
sudo mount -t aufs -o br=boot-image:root-image=ro none boot-image
sudo mount -t proc none boot-image/proc
sudo mount -t sysfs none boot-image/sys
sudo mount -o bind /dev boot-image/dev
sudo cp /home/leszek/Downloads/work/netrunner/arch/manjaroiso/src/hooks/miso* boot-image/usr/lib/initcpio/hooks
sudo cp /home/leszek/Downloads/work/netrunner/arch/manjaroiso/src/install/miso* boot-image/usr/lib/initcpio/install
sudo cp /home/leszek/Downloads/work/netrunner/arch/manjaroiso/configs/shared/mkinitcpio.conf boot-image/etc/mkinitcpio-manjaroiso.conf
_kernver=`cat boot-image/usr/lib/modules/*-MANJARO/version`
sudo chroot boot-image /usr/bin/mkinitcpio -k ${_kernver} -c /etc/mkinitcpio-manjaroiso.conf -g /boot/manjaro.img
# 32Bit
sudo mv boot-image/boot/manjaro.img extract-cd/manjaro/boot/i686/manjaro.img
# 64Bit
#sudo mv boot-image/boot/manjaro.img extract-cd/manjaro/boot/x86_64/manjaro.img
sudo umount -l boot-image/proc boot-image/sys boot-image/dev boot-image
