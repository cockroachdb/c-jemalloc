#!/usr/bin/env sh

set -eu

rm -rf *.c internal/*
curl -sL https://github.com/jemalloc/jemalloc/releases/download/4.0.4/jemalloc-4.0.4.tar.bz2 | tar jxf - -C internal --strip-components=1
(cd internal && ./autogen.sh && ./configure --with-jemalloc-prefix="")
patch -p1 < gitignore.patch

# symlink so cgo compiles them
for source_file in $(make sources); do
  ln -sf $source_file .
done

# restore the repo to what it would look like when first cloned.
# comment this line out while updating upstream.
git clean -dxf
