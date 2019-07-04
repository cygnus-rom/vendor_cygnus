include vendor/rockstar/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/rockstar/config/BoardConfigQcom.mk
endif

include vendor/rockstar/config/BoardConfigSoong.mk
