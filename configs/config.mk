LOCAL_PATH := $(call my-dir)


# Cygnus Extra Packages
PRODUCT_PACKAGES += \
	Launcher \
	MiXplorerPrebuilt \
	RetroMusicPlayer \
	ViaBrowser

# Cygnus Overlays
DEVICE_PACKAGE_OVERLAYS += vendor/cygnus/overlay/
