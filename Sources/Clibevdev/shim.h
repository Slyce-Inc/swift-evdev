#include <libevdev/libevdev.h>

#define EXPORT(x, t) \
static const t _##x = x;

EXPORT(LIBEVDEV_READ_FLAG_SYNC,       unsigned int)
EXPORT(LIBEVDEV_READ_FLAG_NORMAL,     unsigned int)
EXPORT(LIBEVDEV_READ_FLAG_FORCE_SYNC, unsigned int)
EXPORT(LIBEVDEV_READ_FLAG_BLOCKING,   unsigned int)

EXPORT(LIBEVDEV_READ_STATUS_SUCCESS,  unsigned int)
EXPORT(LIBEVDEV_READ_STATUS_SYNC,     unsigned int)
