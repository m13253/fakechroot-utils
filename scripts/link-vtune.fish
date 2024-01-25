#!/usr/bin/fish

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
# To do this, put this script to ~/.config/fish/conf.d/ directory.

for i in /mnt/outside/dev/{apwr_driver_char_dev,pax,sep5,socperf3}
    if test ! -e /dev/(basename $i)
        ln -s $i /dev/(basename $i)
    end
end
