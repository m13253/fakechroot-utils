Build bubblewrap statically:

```bash
mkdir -p "$HOME/build"
pushd "$HOME/build"
git clone https://git.kernel.org/pub/scm/libs/libcap/libcap.git
git clone https://github.com/containers/bubblewrap.git
make -C libcap
cat >libcap.pc <<EOM
Name: libcap
Version:
Description:
Libs: '$HOME/build/libcap/libcap/libcap.a'
Cflags: '-I$HOME/build/libcap/libcap/include'
EOM
PKG_CONFIG_PATH="$PWD" meson setup bubblewrap/builddir bubblewrap --prefix "$HOME/.local/opt/bubblewrap/usr" -D bash_completion=disabled -D man=disabled -D selinux=disabled -D tests=false -D zsh_completion=disabled
ninja -C bubblewrap/builddir install
popd
```
