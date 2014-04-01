sudo mount -t proc none root-image/proc
sudo mount -t sysfs none root-image/sys
sudo mount -o bind /dev root-image/dev
sudo mount -o bind /dev/pts root-image/dev/pts # important for pacman (for signature check)
sudo mv root-image/etc/resolv.conf{,.pacorig}
sudo cp -L /etc/resolv.conf root-image/etc/resolv.conf #this is needed to use networking within the chroot
sudo chroot root-image
sudo mv root-image/etc/resolv.conf.pacorig root-image/etc/resolv.conf
sudo umount root-image/dev/pts
sudo umount root-image/dev
sudo umount root-image/proc
sudo umount root-image/sys