1.  Download ArchLinux bootstrap tarball (or other distro you prefer):

    Go to <https://archlinux.org/download/>, scroll down and choose a mirror server near you, choose the `archlinux-bootstrap-*-x86_64.tar.gz` file.

2.  Verify the PGP signature to make sure no bad guy has touched the tarball.

3.  Extract the bootstrap tarball to `$HOME/archlinux`.

4.  Create your home directory at `$HOME/archlinux/root.x86_64/home/$USER`.

5.  Add your user and group to `$HOME/archlinux/root.x86_64/etc/{passwd,group}`, You normally want to use the same UID/GID as outside.

    Point the home directory path to your newly created one.

6.  Edit the following files, becuase you don’t yet have Vim inside the chroot:

    ```
    $HOME/archlinux/root.x86_64/etc/hosts
    $HOME/archlinux/root.x86_64/etc/locale.gen
    $HOME/archlinux/root.x86_64/etc/pacman.d/mirrorlist
    $HOME/archlinux/root.x86_64/etc/resolv.conf
    ```

7.  Prepare either the program “[bubblewrap](https://github.com/containers/bubblewrap)” or “[proot](https://proot-me.github.io/)” outside the chroot.

    If it is not installed by your system administrator, you may [statically compile it yourself](bwrap-static-build.md), or extract it from a DEB file from [packages.ubuntu.com](https://packages.ubuntu.com/).

    * **Bubblewrap** relies on Linux kernel namespace feature, which may not be available on older systems, or not enabled to you.

      **Build dependencies:**
      * cmake
      * meson (Optional)

      **Runtime dependencies:**
      * glibc
      * libcap

    * **Proot** relies on Linux kernel ptrace feature, which has lower performance than bubblewrap, but widely available.

      **Build dependencies:**
      * None, just download the official pre-compiled binary.

      **Runtime dependencies:**
      * None, statically linked.

8.  Use this `fakechroot.sh` script, but add either `--uid 0 --gid 0` for bubblewrap backend, or `-0` for proot backend, in order to also temporarily give you fakeroot before you get fake-sudo installed.

9.  Inside the chroot, run:

    ```
    # locale-gen
    # pacman-key --init
    # pacman-key --populate archlinux
    # pacman -Sy archlinux-keyring
    # pacman-key --populate archlinux
    # pacman -Su
    # pacman -S --needed base-devel vim
    ```

10. Inside the chroot, install “[fake-sudo](https://aur.archlinux.org/packages/fake-sudo)” from AUR.

    (Note: `makepkg` refuses to work if it detects itself to be root. You might need to modify its source code to bypass the check.)

    After that, you can use your usual UID/GID, and use `sudo` to give you fakeroot.

    You can also use another package called `fakeroot`, if fake-sudo doesn’t work.

    After that, you can remove the `--uid 0 --gid 0` or `-0` options from the `fakechroot.sh` script.

11. If you benefit from this program, consider writing a blog post to introduce this method.
