// SPDX-License-Identifier: GLWTPL

#include <cerrno>
#include <cstdio>
#include <cstring>

#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>

#include <android-base/logging.h>

#include "flashlight_core.h"

#include "flashlight.h"
#include "hardcode.h"

/* device path */
#define FLASH_DEV_PATH				"/dev/flashlight"

/* timeout */
#define FLASH_OFF_TIMEOUT_MS			(5 * 60 * 1000)		/* 5-minute */

static int fd = -1;

static struct flashlight_user_arg arg = {
	.type_id = FLASH_TYPE_ID,
	.ct_id = FLASH_COLOR_TEMP_ID,
};

int flashlight_init(void) {
	if ((fd = open(FLASH_DEV_PATH, O_WRONLY)) < 0) {
		LOG(WARNING) << "failed to open " << FLASH_DEV_PATH << ": " << strerror(errno);

		goto err;
	}

	arg.arg = FLASH_OFF_TIMEOUT_MS;

	if (ioctl(fd, FLASH_IOC_SET_TIME_OUT_TIME_MS, &arg)) {
		LOG(WARNING) << "failed set flashlight timeout to " << FLASH_OFF_TIMEOUT_MS << " ms: " << strerror(errno);

err:
		flashlight_destory();
		return -1;
	}

	return 0;
}

int flashlight_set_state(enum flashlight_state state) {
	if (state < 0 || state >= FLASH_STATE_MAX) {
		LOG(WARNING) << "flashlight_set_state() called with invalid state: " << state;

		return -1;
	}

	if (fd < 0) {
		LOG(WARNING) << "attempted to set flashlight state to " << (state == FLASH_STATE_ON ? "on" : "off") << " before a successful flashlight_init()";

		return -1;
	}

	arg.arg = state;

	if (ioctl(fd, FLASH_IOC_SET_ONOFF, &arg) < 0) {
		LOG(WARNING) << "failed set flashlight state to " << (state == FLASH_STATE_ON ? "on" : "off") << ": " << strerror(errno);

		return -1;
	}

	return 0;
}

void flashlight_destory(void) {
	flashlight_set_state(FLASH_STATE_OFF);

	if (!(fd < 0)) {
		close(fd);

		fd = -1;
	}

	return;
}
