#!/bin/bash

manjaro_kernel=linux310

arch=i686 # x86_64

xorg_packages=$(sed "s|#.*||g" Packages-Xorg | sed "s| ||g" | sed "s|>dvd.*||g"  | sed "s|>blacklist.*||g" | sed "s|>cleanup.*||g" | sed "s|>x86_64.*||g" | sed "s|>i686||g" | sed "s|>free_x64.*||g" | sed "s|>free_uni||g" | sed "s|>nonfree_x64.*||g" | sed "s|>nonfree_uni||g" | sed "s|KERNEL|$manjaro_kernel|g" | sed ':a;N;$!ba;s/\n/ /g')

# 32Bit
#xorg_packages="ati-dri bumblebee catalyst-utils glamor-egl intel-dri libtxc_dxtn libxaw libxpm libxvmc linux310-bbswitch linux310-broadcom-wl linux310-catalyst linux310-nvidia-304xx linux310-nvidia linux310-open-vm-tools-modules linux310-virtualbox-guest-modules nouveau-dri nvidia-304xx-utils nvidia-utils open-vm-tools pangox-compat primus svga-dri virtualbox-guest-utils xf86-input-vmmouse xf86-video-ark xf86-video-ast x86-video-ati xf86-video-cirrus xf86-video-dummy xf86-video-fbdev xf86-video-geode xf86-video-glint xf86-video-i128 xf86-video-intel xf86-video-mach64 xf86-video-mga xf86-video-modesetting xf86-video-neomagic xf86-video-nouveau xf86-video-nv xf86-video-openchrome xf86-video-r128 xf86-video-savage xf86-video-siliconmotion xf86-video-sis xf86-video-tdfx xf86-video-trident xf86-video-vesa xf86-video-vmware xf86-video-voodoo"

#xorg_free_overlay=$(sed "s|#.*||g" Packages-Xorg | sed "s| ||g" | sed "s|>dvd.*||g" | sed "s|>blacklist.*||g" | sed "s|>cleanup.*||g" | sed "s|>x86_64.*||g" | sed "s|>i686||g" | sed "s|>free_x64.*||g" | sed "s|>free_uni||g" | sed "s|>nonfree_x64.*||g" | sed "s|>nonfree_uni.*||g" | sed "s|KERNEL|$manjaro_kernel|g" | sed ':a;N;$!ba;s/\n/ /g')
#xorg_nonfree_overlay=$(sed "s|#.*||g" Packages-Xorg | sed "s| ||g" | sed "s|>dvd.*||g" | sed "s|>blacklist.*||g" | sed "s|>cleanup.*||g" | sed "s|>x86_64.*||g" | sed "s|>i686||g" | sed "s|>free_x64.*||g" | sed "s|>free_uni.*||g" | sed "s|>nonfree_x64.*||g" | sed "s|>nonfree_uni||g" | sed "s|^.*catalyst-legacy.*||g" | sed "s|KERNEL|$manjaro_kernel|g" | sed ':a;N;$!ba;s/\n/ /g')

xorg_packages_cleanup=$(sed "s|#.*||g" Packages-Xorg | grep cleanup | sed "s|>cleanup||g" | sed "s|KERNEL|$manjaro_kernel|g" | sed ':a;N;$!ba;s/\n/ /g')

mkdir -p pkgs-image/opt/livecd/pkgs
sudo mount -t aufs -o br=pkgs-image:root-image=ro none pkgs-image
sudo mount -t aufs -o remount,append:kde-image=ro none pkgs-image
sudo mount -t proc proc pkgs-image/proc
sudo mount -t sysfs sys pkgs-image/sys
sudo mount -o bind /dev pkgs-image/dev
sudo mount -o bind /dev/pts pkgs-image/dev/pts # important for pacman (for signature check)
sudo mv pkgs-image/etc/resolv.conf{,.pacorig}
sudo cp -L /etc/resolv.conf pkgs-image/etc/resolv.conf #this is needed to use networking within the chroot

sudo chroot pkgs-image pacman -v --arch ${arch} --cache /opt/livecd/pkgs -Syw ${xorg_packages} --noconfirm
              if [ ! -z "${xorg_packages_cleanup}" ]; then
                 for xorg_clean in ${xorg_packages_cleanup};
                    do sudo rm pkgs-image/opt/livecd/pkgs/${xorg_clean}
                    done
              fi

cp pacman-gfx.conf pkgs-image/opt/livecd
sudo rm -r pkgs-image/var

# This needs bsdtar to work
./repo-add pkgs-image/opt/livecd/pkgs/gfx-pkgs.db.tar.gz pkgs-image/opt/livecd/pkgs/*pkg*z

sudo umount -l pkgs-image/proc
sudo umount -l pkgs-image/sys
sudo umount -l pkgs-image/dev/pts
sudo umount -l pkgs-image/dev
sudo umount -l pkgs-image

sudo rm -R pkgs-image/.wh*
sudo rm -R pkgs-image/etc/resolv.conf*
sudo rmdir pkgs-image/etc