#!/usr/bin/bash

#
# Copyright (C) 2025 rifux ✿ Vladimir Blinkov
#
# SPDX-License-Identifier: MIT
#

# Vendor
echo 'Fetching Vendor Tree...'
git clone -b 11.0 https://github.com/TTTT555/vendor_xiaomi_begonia \
    vendor/redmi/begonia
git clone -b 12.0 https://github.com/begonia-dev/android_vendor_redmi_begonia-ims \
    vendor/redmi/begonia-ims
git clone -b 11.0 https://github.com/TTTT555/vendor_xiaomi_begonia-firmware \
    vendor/redmi/begonia-firmware

echo 'Fetching [Extra] Vendor Tree...'
git clone -b master https://github.com/TTTT555/dirac \
    vendor/dirac
git clone -b 11 https://github.com/TTTT555/vendor_ANXCamera \
    vendor/ANXCamera
git clone -b master https://github.com/TTTT555/vendor_burial8 \
    vendor/burial8
git clone -b main https://github.com/TTTT555/vendor_gcam64begonia \
    vendor/gcam64begonia

# Kernel
echo 'Fetching Kernel Tree...'
git clone -b cocolite_ross https://github.com/TTTT555/kernel_xiaomi_begonia \
    kernel/xiaomi/mt6785

# Hardware
echo 'Fetching SEPolicy'
git clone -b 11.0 https://github.com/begonia-dev/android_device_mediatek_sepolicy \
    device/mediatek/sepolicy

# FM Radio
echo 'Fetching MTK FM Radio'
git clone -b lineage-18.1 https://github.com/Mediatek-OSS/android_packages_apps_MtkFMRadio \
    packages/apps/MtkFMRadio

# Auto-patch notice
echo -e "
/---------------------------------\\
| [ ! ] IMPORTANT                 |
|                                 |
|      Don't forget to run        |
|         'autopatch.sh'          |
|                                 |
| (should be executed only once!) |
\\---------------------------------/"