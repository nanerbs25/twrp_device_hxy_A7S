// SPDX-License-Identifier: GLWTPL

#include <cerrno>
#include <csignal>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include <fcntl.h>
#include <poll.h>
#include <sys/inotify.h>
#include <sys/signalfd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#include <android-base/logging.h>

#include "ipc.h"
#include "util.h"
#include "flashlight.h"

#define TRIGGER_PATH        "/tmp/.torch_trigger"

static int sigfd = -1;
static int inotify_fd = -1;
static int monitor_fd = -1;
static int fd = -1;

static sigset_t *smask = NULL;

volatile sig_atomic_t ipc_want_quit = 0;

int ipc_init(sigset_t *mask) {
    smask = mask;

    struct stat buf;

    if ((sigfd = signalfd(-1, mask, 0)) < 0) {
        LOG(WARNING) << "failed to open signalfd: " << strerror(errno);

        goto err;
    }

    if (access(TRIGGER_PATH, F_OK) == 0) {

        if (stat(TRIGGER_PATH, &buf) < 0) {
            LOG(WARNING) << "failed to stat " << TRIGGER_PATH << ": " << strerror(errno);

            goto err;
        }

        if (S_ISFIFO(buf.st_mode))
            goto skip_mkfifo;
        else if (unlink(TRIGGER_PATH) < 0) {
            LOG(WARNING) << "failed to unlink " << TRIGGER_PATH << ": " << strerror(errno);

            goto err;
        }
    }

    if (mkfifo(TRIGGER_PATH, 0622) < 0) {
        LOG(WARNING) << "failed to mkfifo " << TRIGGER_PATH << ": " << strerror(errno);

        goto err;
    }
skip_mkfifo:

    if ((inotify_fd = inotify_init()) < 0) {
        LOG(WARNING) << "failed to inotify_init: " << strerror(errno);

        goto err;
    }

    if ((monitor_fd = inotify_add_watch(inotify_fd, TRIGGER_PATH, IN_MODIFY)) < 0) {
        LOG(WARNING) << "failed to watch " << TRIGGER_PATH << ": " << strerror(errno);

        goto err;
    }

    if ((fd = open(TRIGGER_PATH, O_RDONLY | O_NONBLOCK)) < 0) {
        LOG(WARNING) << "failed to open " << TRIGGER_PATH << ": " << strerror(errno);

        goto err;
    }

    if (flashlight_init() < 0) {
err:
        ipc_destory();

        return -1;
    }

    return 0;
}

static void ipc_handle_data(char *buf) {
    char *endptr;
    long int brightness = strtol(buf, &endptr, 10);

    if (*endptr != '\0' && *endptr != '\n') {
        LOG(WARNING) << "invalid brightness " << buf;

        return;
    }

    flashlight_set_state(brightness ? FLASH_STATE_ON : FLASH_STATE_OFF);
}

void ipc_main_loop(void) {
    ssize_t n_read;
    struct inotify_event ev_buff;
    char br_buff[8];

    if (inotify_fd < 0 || monitor_fd < 0 || fd < 0 || !smask) {
        LOG(WARNING) << "attempt to call ipc_main_loop() before a successful ipc_init()";

        return;
    }

    nfds_t nfds = 2;
    struct pollfd fds[nfds];

    fds[0].fd = sigfd;
    fds[0].events = POLLIN;
    fds[1].fd = inotify_fd;
    fds[1].events = POLLIN;

    sigset_t omask;

    for (;;) {
        if (ipc_want_quit)
            break;

        sigprocmask(SIG_BLOCK, smask, &omask);

        if (poll(fds, nfds, -1) < 0) {
            LOG(WARNING) << "poll " << TRIGGER_PATH << " inotify event failed: " << strerror(errno);

            break;
        }

        sigprocmask(SIG_SETMASK, &omask, NULL);

        if (fds[0].revents & POLLERR) {
            LOG(WARNING) << "signalfd poll error";

            break;
        } else if (fds[0].revents & POLLIN)
            break;

        if (fds[1].revents & POLLERR) {
            LOG(WARNING) << TRIGGER_PATH << " poll error";

            break;
        } else if (!(fds[1].revents & POLLIN))
            continue;

        if (safe_read(inotify_fd, (char *) (&ev_buff), sizeof(ev_buff), sizeof(ev_buff)) < 0) {
            LOG(WARNING) << "read " << TRIGGER_PATH << " inotify event failed: " << strerror(errno);

            return;
        }

        if (!(ev_buff.mask & IN_MODIFY))
            continue;

        if ((n_read = safe_read(fd, br_buff, sizeof(br_buff), 0)) < 0) {
            if (errno == EAGAIN)
                continue;

            LOG(WARNING) << "read " << TRIGGER_PATH << " failed: " << strerror(errno);

            return;
        }

        br_buff[n_read] = '\0';

        ipc_handle_data(br_buff);
    }

    return;
}

void ipc_destory(void) {
    flashlight_destory();

    if (!(sigfd < 0)) {
        close(sigfd);

        sigfd = -1;
    }

    if (!(inotify_fd < 0)) {
        if (!(monitor_fd < 0)) {
            inotify_rm_watch(inotify_fd, monitor_fd);

            monitor_fd = -1;
        }

        close(inotify_fd);

        inotify_fd = -1;
    }

    if (!(fd < 0)) {
        close(fd);

        fd = -1;
    }

    if (access(TRIGGER_PATH, F_OK) == 0)
        unlink(TRIGGER_PATH);
}
