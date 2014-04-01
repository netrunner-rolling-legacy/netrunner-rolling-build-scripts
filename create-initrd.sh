#!/bin/bash
cd initrd;
find . | cpio -H newc -ov > ../manjaro-modified.img;
cd ..;
xz --check=crc32 manjaro-modified.img
