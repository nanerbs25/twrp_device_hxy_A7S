#!/bin/sh

# Remove extra fonts if building PBRP to save some space
if [ -d vendor/pb ]; then
	pushd bootable/recovery/gui/theme/common/fonts
	rm -fv {DroidSansFallback,NotoSansCJKjp-Regular,RoboNoto-Medium}.ttf
	popd
fi
