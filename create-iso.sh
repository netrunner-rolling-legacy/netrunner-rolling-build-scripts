#!/bin/bash

# 64 Bit
# xorriso -as mkisofs -iso-level 3 -rock -joliet -max-iso9660-filenames -omit-period -omit-version-number -relaxed-filenames -allow-lowercase -volid "$1" \
# -appid "Netrunner Linux Live" -publisher "Netrunner Linux Team <http://www.netrunner-os.com>" -preparer "prepared by Leszek Lesner" -eltorito-boot isolinux/isolinux.bin \
# -eltorito-catalog isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -isohybrid-mbr "isolinux/isohdpfx.bin" \
# -eltorito-alt-boot -e "EFI/miso/manjaro.img" -no-emul-boot -output "../$2" .

# 32 Bit
xorriso -as mkisofs -iso-level 3 -rock -joliet -max-iso9660-filenames -omit-period -omit-version-number -relaxed-filenames -allow-lowercase -volid "$1" \
-appid "Netrunner Linux Live" -publisher "Netrunner Linux Team <http://www.netrunner-os.com>" -preparer "prepared by Leszek Lesner" -eltorito-boot isolinux/isolinux.bin \
-eltorito-catalog isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -isohybrid-mbr "isolinux/isohdpfx.bin" \
-no-emul-boot -output "../$2" .
