// SPDX-License-Identifier: GLWTPL

#include <csignal>
#include <cstdlib>

#include "ipc.h"

static void cleanup(void) {
    ipc_destory();
}

static void handle_signal(__attribute__((unused)) int signum) {
    ipc_want_quit = 1;
}

int main() {
    sigset_t mask;

    sigemptyset(&mask);
    sigaddset(&mask, SIGTERM);
    sigaddset(&mask, SIGINT);

    if (ipc_init(&mask) < 0)
        goto exit;

    atexit(cleanup);
    signal(SIGTERM, handle_signal);
    signal(SIGINT, handle_signal);

    ipc_main_loop();

exit:
    return ipc_want_quit ? EXIT_SUCCESS : EXIT_FAILURE;
}
