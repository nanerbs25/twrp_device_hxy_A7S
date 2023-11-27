// SPDX-License-Identifier: GLWTPL

#pragma once

#ifdef __cplusplus
#include <csignal>

extern "C" {
#else
#include <signal.h>
#endif

extern volatile sig_atomic_t ipc_want_quit;

int ipc_init(sigset_t *mask);

void ipc_main_loop(void);

void ipc_destory(void);

#ifdef __cplusplus
}
#endif
