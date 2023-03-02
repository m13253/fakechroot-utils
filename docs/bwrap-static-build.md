Build bubblewrap statically:

```bash
mkdir "$HOME/build"
pushd "$HOME/build"
git clone https://github.com/containers/bubblewrap.git
git clone https://git.kernel.org/pub/scm/libs/libcap/libcap.git
pushd libcap
make
popd
pushd bubblewrap
./autogen.sh CFLAGS="-I$HOME/build/libcap/libcap/include" LDFLAGS="-static -L$HOME/build/libcap/libcap"
make
install -Dm0755 bwrap "$HOME/.local/opt/bubblewrap/usr/bin/bwrap"
popd
```
