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
BUILD_ID_LC := $(shell echo $(BUILD_ID) | tr '[:upper:]' '[:lower:]')
$(call inherit-product-if-exists, vendor/cygnus/build/target/product/security/cygnus_security.mk)
PROD_VERSION += Cygnus-$(CYGNUS_VERSION_MAJOR).$(CYGNUS_VERSION_MINOR)-$(TARGET_PRODUCT)-ota-$(BUILD_ID_LC)-REL.$(BUILD_NUMBER_FROM_FILE)

PRODUCT_HOST_PACKAGES += \
    signapk \
    avbtool \
    brotli \
    aapt2 \
    deapexer \
    debugfs \
    zipalign \
    apexer



CYGNUS_VERSION_MAJOR := 3
CYGNUS_VERSION_MINOR := 0
CYGNUS_VERSION := $(CYGNUS_VERSION_MAJOR).$(CYGNUS_VERSION_MINOR)

ifndef CYGNUS_BUILD_TYPE
   CYGNUS_BUILD_TYPE := UNOFFICIAL
endif

ifndef WITH_GAPPS
   CYGNUS_GAPPS := VANILLA
else
   CYGNUS_GAPPS := GAPPS
endif

CYGNUS_BUILD_NUMBER := CYGQ.0$(CYGNUS_VERSION_MAJOR)$(CYGNUS_VERSION_MINOR)0.$(shell date +%Y%m%d)
PACKAGE_VERSION := Cygnus-$(CYGNUS_VERSION)-$(CYGNUS_BUILD_TYPE)-$(CYGNUS_BUILD)-$(CYGNUS_GAPPS)-$(CYGNUS_BUILD_NUMBER)-$(shell date -u +%Y%m%d-%H%M)
MAIN_VERSION := Cygnus-$(CYGNUS_VERSION)-$(shell date +%m%d%H%M)
CAF_REV := $(shell bash vendor/cygnus/configs/caf-tag.sh)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
   ro.cygnus.version=$(CYGNUS_VERSION) \
   ro.cygnus.version.major=$(CYGNUS_VERSION_MAJOR) \
   ro.system.cygnus.build=$(MAIN_VERSION) \
   ro.system.cygnus.releasetype=$(CYGNUS_BUILD_TYPE) \
   ro.system.cygnus.device=$(CYGNUS_BUILD) \
   ro.caf.tag=$(CAF_REV)

ifeq ($(CYGNUS_BUILD_TYPE),OFFICIAL)
   PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
       ro.cygnus.build.number=$(CYGNUS_BUILD_NUMBER)-OFF
   else
       PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
         ro.cygnus.build.number=$(CYGNUS_BUILD_NUMBER)-UNOFF
endif
