// SPDX-License-Identifier: GLWTPL

#include <cerrno>

#include <sys/types.h>
#include <unistd.h>

#include "util.h"

ssize_t safe_read(int fd, char *buff, size_t buff_size, size_t count) {
    ssize_t n_read = 0;
    ssize_t res;
    size_t bytes_to_read = count ? ((count < buff_size) ? count : buff_size) : buff_size;

    for (;;) {
        res = read(fd, buff, bytes_to_read);

        if (res < 0) {
            if (errno == EINTR)
                continue;

            return -1;
        } else if (res == 0)
            return -1;

        n_read += res;
        bytes_to_read -= n_read;
        buff += n_read;

        if (n_read < count)
            continue;

        break;
    }

    return n_read;
}
