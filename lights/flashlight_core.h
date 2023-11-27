/*
 * Copyright (C) 2015 MediaTek Inc.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 */

#pragma once

/* flashlight arguments */
struct flashlight_user_arg {
	int type_id;
	int ct_id;
	int arg;
};

/* ioctl magic number */
#define FLASHLIGHT_MAGIC			'S'

/* ioctl protocol version 1. */
#define FLASH_IOC_SET_TIME_OUT_TIME_MS		_IOR(FLASHLIGHT_MAGIC, 100, int)
#define FLASH_IOC_SET_ONOFF			_IOR(FLASHLIGHT_MAGIC, 115, int)
