#!/bin/sh

# Remove extra fonts if building PBRP to save some space
if [ -d vendor/pb ]; then
	pushd bootable/recovery/gui/theme/common/fonts
	rm -fv {DroidSansFallback,NotoSansCJKjp-Regular,RoboNoto-Medium}.ttf
	popd
fi

export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
