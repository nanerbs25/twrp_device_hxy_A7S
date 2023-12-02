#!/bin/sh

# Remove extra fonts if building PBRP to save some space
if [ -d vendor/pb ]; then
	pushd bootable/recovery/gui/theme/common/fonts
	rm -fv {DroidSansFallback,NotoSansCJKjp-Regular,RoboNoto-Medium}.ttf
	popd
fi

#export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
#OFRP VARS
export OF_SKIP_ORANGEFOX_PROCESS=1
export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
export OF_KEEP_DM_VERITY=1
export OF_KEEP_FORCED_ENCRYPTION=1
export OF_KEEP_DM_VERITY_FORCED_ENCRYPTION=1
export OF_MAINTAINER=nanerbs25
export OF_NO_MIUI_PATCH_WARNING=1
export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export OF_SCREEN_H=2160
export OF_FL_PATH1 := /tmp/.torch_trigger
