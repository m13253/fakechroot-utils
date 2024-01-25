#!/bin/bash

# Allow the chroot environment to access the outside Intel VTune driver.
# Both the outside and the inside needs an installation of Intel VTune.
#
# Verify outside:
#   lsmod | grep sep5
#   id | grep vtune
# Verify inside:
#   pacman -Qi intel-oneapi-basekit
#
# Common issue:
#   vtune: Error: 0x40000024 (No data) -- No data is collected.
# Solution:
#   Use bubblewrap without --unshare-pid
#
# Since the /dev directory is not shared between different calls to fakechroot.sh,
# we need to create the symbolic links every time we enter the chroot environment.
# To do this, write ". link-vtune.bash" in your ~/.bashrc file.

for i in apwr_driver_char_dev pax sep5 socperf3
do
    if [ ! -e "/dev/$i" ]
    then
        ln -s "/mnt/outside/dev/$i" "/dev/$i"
    fi
done
