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


# Props
include vendor/cygnus/configs/props.mk

# Fonts
include vendor/cygnus/configs/fonts.mk

# QCOM common
include device/qcom/common/Android.mk


# Enable SIP+VoIP
PRODUCT_COPY_FILES += frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Disable EAP Proxy because it depends on proprietary headers
# and breaks WPA Supplicant compilation.
DISABLE_EAP_PROXY := true

# Permissions
PRODUCT_COPY_FILES += \
    vendor/cygnus/configs/permissions/privapp-permissions-google-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-google.xml \
    vendor/cygnus/configs/permissions/privapp-permissions-google.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-google.xml \
    vendor/cygnus/prebuilt/OutlineTiles.apk:$(TARGET_COPY_OUT_SYSTEM)/product/overlay/OutlineTiles.apk

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

# Copy cygnus specific init file
PRODUCT_COPY_FILES += vendor/cygnus/prebuilt/root/init.cygnus.rc:root/init.cygnus.rc

# Include hostapd configuration
PRODUCT_COPY_FILES += \
    vendor/cygnus/prebuilt/etc/hostapd/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
    vendor/cygnus/prebuilt/etc/hostapd/hostapd.deny:system/etc/hostapd/hostapd.deny \
    vendor/cygnus/prebuilt/etc/hostapd/hostapd.accept:system/etc/hostapd/hostapd.accept

# Build Themepicker and Servicetracker
PRODUCT_PACKAGES += \
    ThemePicker \
    vendor.qti.hardware.servicetracker@1.2.vendor

# Offline charger
PRODUCT_PACKAGES += \
    charger_res_images \
    product_charger_res_images

# Include support for additional filesystems
PRODUCT_PACKAGES += \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g \
    libjson

# Bluetooth Audio (A2DP)
PRODUCT_PACKAGES += libbthost_if

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += libprotobuf-cpp-full

# RCS Service and more
PRODUCT_PACKAGES += \
    rcscommon \
    rcscommon.xml \
    rcsservice \
    rcs_service_aidl \
    rcs_service_aidl.xml \
    rcs_service_aidl_static \
    rcs_service_api \
    extphonelib \
    extphonelib-product \
    extphonelib.xml \
    extphonelib_product.xml \
    rcs_service_api.xml

# MSIM manual provisioning
PRODUCT_PACKAGES += telephony-ext
PRODUCT_BOOT_JARS += telephony-ext

# TCP Connection Management
PRODUCT_PACKAGES += tcmiface
PRODUCT_BOOT_JARS += tcmiface

# World APN list
PRODUCT_COPY_FILES += \
    vendor/cygnus/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml

# include additional build utilities
include vendor/cygnus/utils.mk

# Cygnus Overlays
include vendor/cygnus-overlays/overlays.mk

# Don't compile SystemUITests
EXCLUDE_SYSTEMUI_TESTS := true

# Disable Java debug info
USE_DEX2OAT_DEBUG := false
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Launcher
PRODUCT_PACKAGES += \
    TrebuchetQuickStep

# Bootanimation
ifeq ($(TARGET_BOOT_ANIMATION_RES),1080)
     PRODUCT_COPY_FILES += vendor/cygnus/bootanimation/bootanimation-dark_1080.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),1440)
     PRODUCT_COPY_FILES += vendor/cygnus/bootanimation/bootanimation-dark_1440.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else ifeq ($(TARGET_BOOT_ANIMATION_RES),720)
     PRODUCT_COPY_FILES += vendor/cygnus/bootanimation/bootanimation-dark_720.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else
    ifeq ($(TARGET_BOOT_ANIMATION_RES),)
        $(warning "Cygnus: TARGET_BOOT_ANIMATION_RES is undefined, assuming 1080p")
    else
        $(warning "Cygnus: Current bootanimation res is not supported, forcing 1080p")
    endif
    PRODUCT_COPY_FILES += vendor/cygnus/bootanimation/bootanimation-dark_1080.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
endif

ifeq ($(WITH_GAPPS),true)
      $(call inherit-product-if-exists, vendor/gms/products/gms.mk)
endif

# Inherit from Cygnus common tree.
include device/cygnus/common/common.mk

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED ?= true

ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)

PRODUCT_PACKAGES += \
    FaceUnlockService

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face_unlock_service.enabled=$(TARGET_FACE_UNLOCK_SUPPORTED)

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml

endif

# QTI BT
include vendor/qcom/opensource/commonsys-intf/bluetooth/bt-commonsys-intf-board.mk
$(call inherit-product, vendor/qcom/opensource/commonsys-intf/bluetooth/bt-system-opensource-product.mk)

# Accents
PRODUCT_PACKAGES += \
    AccentColoriOSBlueOverlay \
    AccentColorHadalZoneOverlay \
    AccentColorLostInForestOverlay \
    AccentColorMagentaOverlay \
    AccentColorPixelBlueOverlay \
    AccentColorPurpleHeatOverlay \
    AccentColorRedOverlay \
    AccentColorRoseOverlay \
    AccentColorScooterOverlay \
    AccentColorSlateOverlay \
    AccentColorSuperNovaOverlay \
    AccentColorTealOverlay \
    AccentColorTorchRedOverlay


# Fonts
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/cygnus/prebuilt/fonts/,$(TARGET_COPY_OUT_PRODUCT)/fonts) \
    $(call find-copy-subdir-files,*,vendor/cygnus/prebuilt/fonts-system/,$(TARGET_COPY_OUT_SYSTEM)/fonts) \
    vendor/cygnus/prebuilt/etc/fonts_customization.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/fonts_customization.xml

# Common
$(call inherit-product, device/qcom/common/common.mk)

PRODUCT_PACKAGES += \
    FontManropeOverlay \
    FontOnePlusSansOverlay

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml

# Blurs
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1

# Flatten APEXs for performance
OVERRIDE_TARGET_FLATTEN_APEX := true
# This needs to be specified explicitly to override ro.apex.updatable=true from
# prebuilt vendors, as init reads /product/build.prop after /vendor/build.prop
PRODUCT_PRODUCT_PROPERTIES += ro.apex.updatable=false

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig \

#Additonal Flags
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
WITH_DEXPREOPT_DEBUG_INFO := false
USE_DEX2OAT_DEBUG := false
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true
