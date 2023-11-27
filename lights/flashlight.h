// SPDX-License-Identifier: GLWTPL

#pragma once

/* flashlight on/off */
enum flashlight_state {
	FLASH_STATE_OFF				= 0,
	FLASH_STATE_ON				= 1,
	FLASH_STATE_MAX,
};

#ifdef __cplusplus
extern "C" {
#endif

int flashlight_init(void);

int flashlight_set_state(enum flashlight_state state);

void flashlight_destory(void);

#ifdef __cplusplus
}
#endif
