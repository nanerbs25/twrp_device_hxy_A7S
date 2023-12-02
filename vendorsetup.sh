#!/bin/sh

# Remove extra fonts if building PBRP to save some space
if [ -d vendor/pb ]; then
	pushd bootable/recovery/gui/theme/common/fonts
	rm -fv {DroidSansFallback,NotoSansCJKjp-Regular,RoboNoto-Medium}.ttf
	popd
fi

#export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
#OFRP VARS
export OF_MAINTAINER=nanerbs25
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export OF_SCREEN_H=2400
export OF_FL_PATH1=/tmp
export OF_STATUS_H=80
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48
export OF_CLOCK_POS=1
export OF_ALLOW_DISABLE_NAVBAR=0
export FOX_DELETE_AROMAFM=1
export FOX_BUILD_TYPE="Beta"
export FOX_REMOVE_BASH=1
