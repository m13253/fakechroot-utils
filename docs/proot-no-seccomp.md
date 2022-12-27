If running proot does nothing; with arguments `-v 1`, it shows “proot info: vpid 1: terminated with signal 11”.

This is because proot tries to use seccomp for acceleration but fails. ([Related issue](https://github.com/proot-me/proot/issues/336))

The solution is to insert somewhere in `fakechroot.sh`:
```bash
export PROOT_NO_SECCOMP=1
```
