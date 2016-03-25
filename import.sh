#!/usr/bin/env sh

set -eu

rm -rf *.c internal/*
curl -sL https://github.com/jemalloc/jemalloc/releases/download/4.1.0/jemalloc-4.1.0.tar.bz2 | tar jxf - -C internal --strip-components=1

# You need to manually run the following code.
# on OSX:
# (cd internal && ./autogen.sh && ./configure --enable-prof --with-jemalloc-prefix="")
# rm -r darwin_includes
# git clean -Xn -- internal/include/jemalloc | sed 's/.* //' | xargs -I % rsync -R % darwin_includes/
#
# on Linux:
# (cd internal && ./autogen.sh && ./configure --enable-prof)
# rm -r linux_includes
# git clean -Xn -- internal/include/jemalloc | sed 's/.* //' | xargs -I % rsync -R % linux_includes/

# symlink so cgo compiles them
for source_file in $(make sources); do
  ln -sf $source_file .
done

# restore the repo to what it would look like when first cloned.
# comment this line out while updating upstream.
git clean -dxf
