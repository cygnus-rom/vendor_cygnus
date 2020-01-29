LOCAL_PATH := $(call my-dir)


# Cygnus Extra Packages
PRODUCT_PACKAGES += \
	MiXplorerPrebuilt \
	RetroMusicPlayer \
	ViaBrowser

# Cygnus Overlays
DEVICE_PACKAGE_OVERLAYS += vendor/cygnus/overlay/

PRODUCT_PACKAGES += \
	cygnus-overlays
