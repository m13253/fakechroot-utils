If you use proot backend, when you install packages with `pacman`, you might see the following error:
```
proot: ./path/path.c:547: compare_paths2: Assertion `length2 > 0` failed.
```
After that, poot quits, killing all child processes. ([Related issue](https://github.com/proot-me/proot/issues/182))

Try to edit `$CHROOT_PATH/usr/lib/tmpfiles.d/dbus.conf` and comment out the following line:
```
L /var/lib/dbus/machine-id - - - - /etc/machine-id
```
Then, remove `$CHROOT_PATH/var/lib/pacman/db.lck` if it exists, and retry.
