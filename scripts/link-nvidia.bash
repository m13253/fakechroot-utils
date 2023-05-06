#!/bin/bash

# Allow the chroot environment to access the outside NVIDIA GPU devices.
# The outside requires an installation of NVIDIA driver.
# The chroot environment requires a separate installation of CUDA toolkit.

for i in /mnt/outside/dev/nvidia*
do
    if [ ! -e "/dev/$(basename "$i")" ]
    then
        ln -s "$i" "/dev/$(basename "$i")"
    fi
done
