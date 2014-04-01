netrunnerarch-build-scripts
===========================

Some useful scripts to manually build netrunnerarch.

chroot_to_kde.sh
----------------

* Chroot into kde-image live system

*chroot_to_kde.sh usually only works if mount_kde_overlay_rw.sh was executed beforehand*

chroot_to_root.sh
-----------------

* Chroot into root-image live system

mount_kde_overlay_rw.sh
------------------------

* Mounts kde-image writable ontop of root-image readable

create-boot-initrd-with-miso.sh
-------------------------------

* Recreate miso enabled initrd for live system

*Useful if modified miso scripts or necessary on kernel upgrade*

create-bootlogo.sh
-------------------

* Create bootlogo cpio archive for modified isolinux menu

create-initrd.sh
-----------------

* Create initrd cpio file compressed with correct xz parameters

create-iso.sh
--------------

* Create ISO with xorriso (for 64 Bit EFI enabled) with USB dd'ing support

make-squashfs.sh
-----------------

* Create netrunner-snapshot.sqfs from squash folder

pacman-key-tipp.txt
--------------------

* Necessary pacman commands to install manually something in chrooted environment



