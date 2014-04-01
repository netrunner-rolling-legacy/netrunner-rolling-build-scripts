#!/bin/bash
cd isolinux;
find . | cpio -ov > ../bootlogo
