# Set device-specific HALs into project pathmap
define set-device-specific-path
$(if $(USE_DEVICE_SPECIFIC_$(1)), \
    $(if $(DEVICE_SPECIFIC_$(1)_PATH), \
        $(eval path := $(DEVICE_SPECIFIC_$(1)_PATH)), \
        $(eval path := $(TARGET_DEVICE_DIR)/$(2))), \
    $(eval path := $(3))) \
$(call project-set-path,$(2),$(strip $(path)))
endef

$(call set-device-specific-path,AUDIO,audio,hardware/qcom/$(HAL_VARIANT)/audio)
$(call set-device-specific-path,DISPLAY,display,hardware/qcom/$(HAL_VARIANT)/display)
$(call set-device-specific-path,MEDIA,media,hardware/qcom/$(HAL_VARIANT)/media)
$(call set-device-specific-path,BT_VENDOR,bt-vendor,hardware/qcom/bt)
$(call set-device-specific-path,DATA_IPA_CFG_MGR,data-ipa-cfg-mgr,vendor/qcom/opensource/data-ipa-cfg-mgr)
$(call set-device-specific-path,DATASERVICES,dataservices,vendor/qcom/opensource/dataservices)
$(call set-device-specific-path,VR,vr,hardware/qcom/vr)
$(call set-device-specific-path,WLAN,wlan,hardware/qcom/wlan)

PRODUCT_CFI_INCLUDE_PATHS += \
    hardware/qcom/wlan/qcwcn/wpa_supplicant_8_lib
