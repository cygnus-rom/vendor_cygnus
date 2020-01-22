# Versioning
ANDROID_VERSION = 10
PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 0
CYGNUS_VERSION = $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)

# Official and Unofficial builds
ifndef CYGNUS_BUILD_TYPE
CYGNUS_BUILD_TYPE := UNOFFICIAL
endif

# Packaging
LINEAGE_VERSION := Cygnus-$(CYGNUS_VERSION)-$(shell date +%Y%m%d)-$(CYGNUS_BUILD_TYPE)_$(PRODUCT_DEVICE)
LINEAGE_DISPLAY_VERSION := Cygnus-$(CYGNUS_VERSION)-$(CYGNUS_BUILD_TYPE)_$(PRODUCT_DEVICE)

# Versioning Props
ADDITIONAL_BUILD_PROPERTIES += \
    ro.cygnus.version=$(CYGNUS_VERSION) \
    ro.cygnus.releasetype=$(CYGNUS_BUILD_TYPE)
    
# Cygnus Extra Packages
PRODUCT_PACKAGES += \
	Launcher \
	MiXplorerPrebuilt \
	RetroMusicPlayer
