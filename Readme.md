# fakechroot.sh

Chroot without root privilege on shared system.

Suitable for setting up your work environment on a shared machine in an academic lab, running old Ubuntu or CentOS.

## Index

1. **Task:** Preparing an ArchLinux chroot environment.

   **Docs:**
   * [docs/prepare-archlinux.md](docs/prepare-archlinux.md)

   **Scripts:**
   * [scripts/fakechroot.sh](scripts/fakechroot.sh)

2. **Task:** Clearing up environment variable passed from outside the chroot.

   **Scripts:**
   * [scripts/clear-env.bash](scripts/clear-env.bash)
   * [scripts/clear-env.fish](scripts/clear-env.fish)

3. **Task:** Use Visual Studio Code to connect to the remote chroot environment via SSH.

   **Docs:**
   * [docs/vscode-remote.md](docs/vscode-remote.md)

4. **Issue:** `man` shows error message: “error while loading shared libraries”

   **Docs:**
   * [docs/man-apparmor.md](docs/man-apparmor.md)

5. **Issue:** Proot does nothing; with arguments `-v 1`, it shows “proot info: vpid 1: terminated with signal 11”.

   **Docs:**
   * [docs/proot-no-seccomp.md](docs/proot-no-seccomp.md)

6. **Issue:** `pacman` produces error message: “proot: ./path/path.c:547: compare_paths2: Assertion `length2 > 0` failed.”

   **Docs:**
   * [docs/proot-compare_paths2.md](docs/proot-compare_paths2.md]

## License

Licensed under WTFPL, version 2.

License terms available at: <http://www.wtfpl.net/about/>.

If you benefit from this program, please consider writing a blog post to introduce this method.
