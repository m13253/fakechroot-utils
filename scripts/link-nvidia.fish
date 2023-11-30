#!/usr/bin/fish

# Allow the chroot environment to access the outside NVIDIA GPU devices.
# The outside requires an installation of NVIDIA driver.
# The chroot environment requires a separate installation of CUDA toolkit.
#
# Since the /dev directory is not shared between different calls to fakechroot.sh,
# we need to create the symbolic links every time we enter the chroot environment.
# To do this, put this script to ~/.config/fish/conf.d/ directory.

for i in /mnt/outside/dev/nvidia*
    if test ! -e /dev/(basename $i)
        ln -s $i /dev/(basename $i)
    end
end

# Solves the "Failed to initialize NVML: Driver/library version mismatch" problem
mkdir -p /usr/local/lib/nvidia
ln -fs /mnt/outside/lib/x86_64-linux-gnu/libcuda.so.1 /usr/local/lib/nvidia/libcuda.so.1
ln -fs /mnt/outside/lib/x86_64-linux-gnu/libnvidia-ml.so.1 /usr/local/lib/nvidia/libnvidia-ml.so.1
set -gx LD_LIBRARY_PATH (/usr/bin/python3 -c 'import os, sys; p = sys.argv[2].split(chr(58)); print(chr(58).join(p + [i for i in os.getenv(sys.argv[1], str()).split(chr(58)) if i and i not in p]))' LD_LIBRARY_PATH /usr/local/lib/nvidia | string collect)
