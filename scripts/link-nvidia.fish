#!/usr/bin/fish

# Allow the chroot environment to access the outside NVIDIA GPU devices.
# The outside requires an installation of NVIDIA driver.
# The chroot environment requires a separate installation of CUDA toolkit.

for i in /mnt/outside/dev/nvidia*
    if test ! -e /dev/(basename $i)
        ln -s $i /dev/(basename $i)
    end
end
