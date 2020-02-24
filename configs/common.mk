#
# Copyright (C) 2020 Cygnus
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Include support for GApps backup
PRODUCT_COPY_FILES += \
    vendor/cygnus/prebuilt/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/cygnus/prebuilt/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/cygnus/prebuilt/bin/50-backuptool.sh:system/addon.d/50-backuptool.sh

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/cygnus/prebuilt/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/cygnus/prebuilt/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/cygnus/prebuilt/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Include hostapd configuration
PRODUCT_COPY_FILES += \
    vendor/cygnus/prebuilt/etc/hostapd/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
    vendor/cygnus/prebuilt/etc/hostapd/hostapd.deny:system/etc/hostapd/hostapd.deny \
    vendor/cygnus/prebuilt/etc/hostapd/hostapd.accept:system/etc/hostapd/hostapd.accept

# Build Snapdragon apps
PRODUCT_PACKAGES += \
    SnapdragonGallery

# Include support for additional filesystems
PRODUCT_PACKAGES += \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Bluetooth Audio (A2DP)
PRODUCT_PACKAGES += libbthost_if

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += libprotobuf-cpp-full

# RCS Service
PRODUCT_PACKAGES += \
    rcs_service_aidl \
    rcs_service_aidl.xml \
    rcs_service_aidl_static \
    rcs_service_api \
    rcs_service_api.xml

# Props
include vendor/cygnus/configs/props.mk

# TCP Connection Management
PRODUCT_PACKAGES += tcmiface
PRODUCT_BOOT_JARS += tcmiface

# Version
$(call inherit-product, vendor/cygnus/configs/version.mk)

# World APN list
PRODUCT_COPY_FILES += \
    vendor/cygnus/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

ifneq ($(HOST_OS),linux)
ifneq ($(sdclang_already_warned),true)
$(warning **********************************************)
$(warning * SDCLANG is not supported on non-linux hosts.)
$(warning **********************************************)
sdclang_already_warned := true
endif
else
# include definitions for SDCLANG
include vendor/cygnus/sdclang/sdclang.mk
endif

# include additional build utilities
include vendor/cygnus/utils.mk

# Cygnus Overlays
include vendor/cygnus-overlays/overlays.mk
