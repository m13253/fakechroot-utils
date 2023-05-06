#!/usr/bin/fish

# Allow the chroot environment to access the outside NVIDIA GPU devices.
# The outside requires an installation of NVIDIA driver.
# The chroot environment requires a separate installation of CUDA toolkit.
#
# Since the /dev directory is not shared between different calls to fakechroot.sh,
# we need to create the symbolic links every time we enter the chroot environment.
# To do this, write "source link-nvidia.fish" in your ~/.config/fish/config.fish file.

for i in /mnt/outside/dev/nvidia*
    if test ! -e /dev/(basename $i)
        ln -s $i /dev/(basename $i)
    end
end
