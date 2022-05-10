If you use bubblewrap backend, and the host system is Ubuntu, you may randomly get the following error when you try to run `man`:
```
man: error while loading shared libraries: libmandb-*.so: cannot open shared object file: No such file or directory
```

Sometimes:
```
man: error while loading shared libraries: liblesspipe-*.so: cannot open shared object file: Permission denied
```

This is due to [AppArmor protecting the path /usr/bin/man](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=994030). AppArmor has no idea of Linux kernel namespace, so as long as your executable file is located at `/usr/bin/man`, even if inside a chroot environment, AppArmor still tries to restrict what dynamic libraries it can load. Interestingly, this protection is only sometimes effective.

Obviously, you don’t have permission to change host AppArmor configuration. The workaround is to copy it into another path:
```
cp /usr/bin/man /usr/local/bin/man
```
Remember to do this every time when the package `man-db` or `mandoc` receives a version upgrade.
