#!/bin/sh

# Chroot without root privilege on shared system.
# Suitable for setting up your work environment on a shared lab machine, running old Ubuntu or CentOS.

# Licensed under WTFPL, version 2.
# License terms available at: http://www.wtfpl.net/about/


# If you prefer another shell, change "${SHELL:-/bin/bash}" to whatever you like.
[ -z "$*" ] && exec "$0" ${SHELL:-/bin/bash} -i

# Change this if you have different chroot directory.
CHROOT_PATH="$HOME/archlinux/root.x86_64"

# Use bubblewrap (https://github.com/containers/bubblewrap)
exec bwrap --unshare-user-try --unshare-ipc --unshare-pid --unshare-uts --unshare-cgroup-try --hostname archlinux --dev-bind "$CHROOT_PATH" / --dev-bind / /mnt/outside --dev-bind /sys /sys --dev-bind /tmp /tmp --dev-bind /run/shm /run/shm --dev /dev --proc /proc "$@"

# If bubblewrap is unavailable, try proot (https://proot-me.github.io/)
# It has lower performance than bubblewrap.
exec proot -r "$CHROOT_PATH" -b /:/mnt/outside -b /dev/ -b /sys/ -b /proc/ -b /tmp/ -b /run/shm "$@"
