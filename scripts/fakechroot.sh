#!/bin/sh

# Chroot without root privilege on shared system.
# Suitable for setting up your work environment on a shared lab machine, running old Ubuntu or CentOS.

# Licensed under WTFPL, version 2.
# License terms available at: http://www.wtfpl.net/about/


# If you prefer another shell, change "${SHELL:-/bin/bash}" to whatever you like.
[ -z "$*" ] && exec "$0" ${SHELL:-/bin/bash} -i

# Change this if you have different chroot directory.
CHROOT_PATH="$HOME/archlinux/root.x86_64"

# Change this if bwrap and proot is installed to a different path,
# for example, "$HOME/.local/opt/bubblewrap/usr/bin/bwrap", "$HOME/.local/bin/proot".
BWRAP_PATH="bwrap"
PROOT_PATH="proot"

# Change this if you want /tmp and /run/shm to be mapped to somewhere else.
TMP_PATH="/run/user/$(id -ru)/archlinux"
mkdir -p "$TMP_PATH/tmp/" "$TMP_PATH/run/shm/"

# Use bubblewrap (https://github.com/containers/bubblewrap)
exec "$BWRAP_PATH" --unshare-user-try --unshare-ipc --unshare-pid --unshare-uts --unshare-cgroup-try --hostname archlinux --dev-bind "$CHROOT_PATH" / --dev-bind / /mnt/outside --dev-bind /sys /sys --dev-bind "$TMP_PATH/tmp" /tmp --dev-bind "$TMP_PATH/run/shm" /run/shm --dev /dev --proc /proc "$@"

# If bubblewrap is unavailable, try proot (https://proot-me.github.io/)
# It has lower performance than bubblewrap.
# Note 1: If the host machine does not have /run/shm, remove "-b /run/shm".
# Note 2: For SIGSEGV issue, check https://github.com/proot-me/proot/issues/336 (December 2022).
# Note 3: If, during pacman installation, you see the error:
#         proot: ./path/path.c:547: compare_paths2: Assertion `length2 > 0' failed.
#         Try to edit $CHROOT_PATH/usr/lib/tmpfiles.d/dbus.conf and comment the line:
#         L /var/lib/dbus/machine-id - - - - /etc/machine-id
#         Then, remove the file $CHROOT_PATH/var/lib/pacman/db.lck if exists, and retry.
exec "$PROOT_PATH" -r "$CHROOT_PATH" -b /:/mnt/outside -b /dev/ -b /sys/ -b /proc/ -b "$TMP_PATH/tmp/":/tmp/ -b "$TMP_PATH/run/shm/":/run/shm/ "$@"
