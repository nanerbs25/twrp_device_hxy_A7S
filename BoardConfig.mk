#
# Copyright (C) 2021 TeamWin Recovery Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


DEVICE_PATH := device/hxy/A7S

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a53

TARGET_USES_64_BIT_BINDER := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := g2037spb_v1_ga_ym_a7s_gq
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := mt6737m

# Assert
TARGET_OTA_ASSERT_DEVICE := A7S

# Kernel
LZMA_RAMDISK_TARGETS := boot,recovery
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,32N2 androidboot.usbconfigfs=true
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_IMAGE_NAME := zImage-dtb
BOARD_KERNEL_PAGESIZE := 2048
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_BASE          := 0x40000000
BOARD_KERNEL_TAGS_OFFSET   := 0x0e000000
BOARD_KERNEL_OFFSET        := 0x00008000
BOARD_KERNEL_SECOND_OFFSET := 0x00f00000
BOARD_RAMDISK_OFFSET       := 0x04000000
BOARD_DTB_OFFSET           := 0x0e000000
TARGET_KERNEL_ARCH := arm
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/zImage-dtb
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_KERNEL_SECOND_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_DTBOIMG_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 117440512
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1610612736

# Workaround for error copying vendor files to recovery ramdisk
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Dynamic Partition
BOARD_SUPER_PARTITION_SIZE := 3261071360
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_SIZE := 3261071360
BOARD_MAIN_PARTITION_LIST := \
        product \
        system \
        vendor

# Metadata
BOARD_USES_METADATA_PARTITION := true
BOARD_ROOT_EXTRA_FOLDERS += metadata

1# System as root
#BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_SUPPRESS_SECURE_ERASE := true

# File systems
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USES_MKE2FS := true

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_LARGE_FILESYSTEM := true

# TWRP specific build flags
TARGET_SCREEN_DENSITY := 320
TW_THEME := portrait_hdpi
#TW_Y_OFFSET := 54
#TW_H_OFFSET := -54
TW_CUSTOM_CPU_TEMP_PATH := /sys/devices/virtual/thermal/thermal_zone1/temp
TW_CUSTOM_BATTERY_PATH := "/sys/class/power_supply/battery"
RECOVERY_SDCARD_ON_DATA := true
BOARD_CHARGER_DISABLE_INIT_BLANK := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_USE_TOOLBOX := false
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_SCREEN_BLANK_ON_BOOT := true
TW_EXCLUDE_TWRPAPP := true
TW_EXCLUDE_SUPERSU := true
TW_EXCLUDE_TZDATA := true
DEVICE_SCREEN_WIDTH := 720
DEVICE_SCREEN_HEIGHT := 1600
TW_INCLUDE_SETPROP := true
TW_EXCLUDE_LPTOOLS := true
TW_EXCLUDE_LPDUMP := true
TW_EXCLUDE_BASH := true
TW_EXCLUDE_NANO := true
TW_EXCLUDE_FB2PNG := true

# Crypto
#TW_INCLUDE_CRYPTO := true
#TW_INCLUDE_CRYPTO_FBE := true
#TW_INCLUDE_FBE := true
#TW_INCLUDE_FBE_METADATA_DECRYPT := true

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_USE_FSCRYPT_POLICY := 2
TW_EXCLUDE_APEX := true
TW_PREPARE_DATA_MEDIA_EARLY := true

TARGET_RECOVERY_DEVICE_MODULES += \
    libkeymaster4 \
    libpuresoftkeymasterdevice \
    ashmemd_aidl_interface-cpp \
    libashmemd_client

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/ashmemd_aidl_interface-cpp.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libashmemd_client.so

# Hack: prevent anti rollback
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31

# Debug
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# PBRP specific build flags
PB_DISABLE_DEFAULT_DM_VERITY := true
PB_ENGLISH := true
PB_TORCH_PATH := /tmp/.torch_trigger

# SHRP Build Flags
SHRP_PATH := device/hxy/A7S
SHRP_MAINTAINER := nanerbs25
SHRP_DEVICE_CODE := A7S
SHRP_HAS_RECOVERY_PARTITION := true
SHRP_EDL_MODE := 0
SHRP_EXTERNAL := /external_sd
SHRP_INTERNAL := /sdcard
SHRP_OTG := /usbotg
SHRP_REC := /dev/block/platform/bootdevice/by-name/recovery
SHRP_REC_TYPE := Treble
SHRP_DEVICE_TYPE := A-Only
SHRP_FLASH := 1
SHRP_OFFICIAL := false
SHRP_DARK := true
SHRP_NOTCH := true
SHRP_FONP_1 := /tmp/.torch_trigger
SHRP_FLASH_MAX_BRIGHTNESS := 255
#SHRP_STATUSBAR_RIGHT_PADDING := 20
#SHRP_STATUSBAR_LEFT_PADDING := 20
SHRP_CUSTOM_FLASHLIGHT := true

#OFRP VARS
#OF_SKIP_ORANGEFOX_PROCESS=1
#OF_DONT_PATCH_ENCRYPTED_DEVICE=1
#OF_KEEP_DM_VERITY=1
#OF_KEEP_FORCED_ENCRYPTION=1
#OF_KEEP_DM_VERITY_FORCED_ENCRYPTION=1
#OF_MAINTAINER=nanerbs25
#OF_NO_MIUI_PATCH_WARNING=1
#OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
#OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
#FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
#OF_SCREEN_H=2160

OF_FL_PATH1 := /tmp/.torch_trigger
#OF_FL_PATH2 := /sys/class/leds/led:switch
