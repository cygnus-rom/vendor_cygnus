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

CYGNUS_VERSION_MAJOR := 4
CYGNUS_VERSION_MINOR := 0
CYGNUS_VERSION := $(CYGNUS_VERSION_MAJOR).$(CYGNUS_VERSION_MINOR)

ifndef CYGNUS_BUILD_TYPE
   CYGNUS_BUILD_TYPE := BETA
endif

ifndef WITH_GAPPS
   CYGNUS_GAPPS := VANILLA
else
   CYGNUS_GAPPS := GAPPS
endif

CYGNUS_BUILD_NUMBER := CYGR.0$(CYGNUS_VERSION_MAJOR)$(CYGNUS_VERSION_MINOR)0.$(shell date +%Y%m%d-%H%M)
PACKAGE_VERSION := Cygnus-$(CYGNUS_VERSION)-$(CYGNUS_BUILD_TYPE)-$(CYGNUS_BUILD)-$(CYGNUS_GAPPS)-$(CYGNUS_BUILD_NUMBER)
MAIN_VERSION := Cygnus-$(CYGNUS_VERSION)-$(shell date +%m%d%H%M)
CAF_REV := $(shell bash vendor/cygnus/configs/caf-tag.sh)

ADDITIONAL_SYSTEM_PROPERTIES += \
   ro.cygnus.version=$(CYGNUS_VERSION) \
   ro.cygnus.version.major=$(CYGNUS_VERSION_MAJOR) \
   ro.system.cygnus.build=$(MAIN_VERSION) \
   ro.system.cygnus.releasetype=$(CYGNUS_BUILD_TYPE) \
   ro.system.cygnus.device=$(CYGNUS_BUILD) \
   ro.caf.tag=$(CAF_REV)

