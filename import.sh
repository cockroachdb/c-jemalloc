#!/usr/bin/env sh

MAKE=${MAKE:-make}
set -eu

rm -rf internal/*
find . -type l -not -path './.git/*' -exec rm {} \;
curl -sfSL https://github.com/jemalloc/jemalloc/releases/download/4.5.0/jemalloc-4.5.0.tar.bz2 | tar jxf - -C internal --strip-components=1

# symlink source files so cgo compiles them. Link the license to make
# it more discoverable in this repo.
for source_file in $($MAKE sources) internal/COPYING; do
  ln -sf "$source_file" .
done

# TODO(tamird): restore --enable-prof on all ./configure lines below when
# https://github.com/jemalloc/jemalloc/issues/585 is resolved.

# You need to manually run the following code.
# on OSX:
# (cd internal && MACOSX_DEPLOYMENT_TARGET=10.9 ./configure)
# <compare "Build parameters" in internal/Makefile to cgo flags in cgo_flags.go> and adjust the latter.
# rm -r darwin_includes
# git clean -Xn -- internal/include/jemalloc | sed 's/.* //' | xargs -I % rsync -R % darwin_includes/
#
# on Linux:
# cd internal
# echo 'ac_cv_func_issetugid=no' >> config.cache
# echo 'ac_cv_func_secure_getenv=no' >> config.cache
# echo 'je_cv_glibc_malloc_hook=no' >> config.cache
# echo 'je_cv_glibc_memalign_hook=no' >> config.cache
# echo 'je_cv_madv_free=no' >> config.cache
# echo 'je_cv_pthread_mutex_adaptive_np=no' >> config.cache
# echo 'je_cv_thp=no' >> config.cache
# ./configure -C
# rm config.cache
# cd -
# <compare "Build parameters" in internal/Makefile to cgo flags in cgo_flags.go> and adjust the latter.
# rm -r linux_includes
# git clean -Xn -- internal/include/jemalloc | sed 's/.* //' | xargs -I % rsync -R % linux_includes/
#
# on FreeBSD:
# (cd internal && ./configure)
# <compare "Build parameters" in internal/Makefile to cgo flags in cgo_flags.go> and adjust the latter.
# rm -r freebsd_includes
# git clean -Xn -- internal/include/jemalloc | sed 's/.* //' | xargs -I % rsync -R % freebsd_includes/
#
# After committing locally you should run the command below to ensure your repo
# is in a clean state and then build/test cockroachdb with the new version:
#   git clean -dXf
