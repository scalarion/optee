CROSS_COMPILE 	?= arm-linux-gnueabihf-
PLATFORM		?= vexpress-qemu_virt
TA_DEV_KIT_DIR  ?= ../../qemu/optee_os/out/arm/export-ta_arm32

CFG_TEE_TA_LOG_LEVEL ?= 4

# The UUID for the Trusted Application
BINARY=b7747463-bebd-4662-9d5b-7f759cf3100b

-include $(TA_DEV_KIT_DIR)/mk/ta_dev_kit.mk

ifeq ($(wildcard $(TA_DEV_KIT_DIR)/mk/ta_dev_kit.mk), )
clean:
	@echo 'Note: $$(TA_DEV_KIT_DIR)/mk/ta_dev_kit.mk not found, cannot clean TA'
	@echo 'Note: TA_DEV_KIT_DIR=$(TA_DEV_KIT_DIR)'
endif
