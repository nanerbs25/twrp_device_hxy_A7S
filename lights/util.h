// SPDX-License-Identifier: GLWTPL

#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#include <sys/types.h>

ssize_t safe_read(int fd, char *buff, size_t buff_size, size_t count);

#ifdef __cplusplus
}
#endif
