// Package jemalloc uses the cgo compilation facilities to build the
// jemalloc library.
package jemalloc

// #cgo CFLAGS: -Iinternal/include -std=gnu11 -pipe -g3 -fvisibility=hidden -O3 -funroll-loops
// #cgo CPPFLAGS: -D_REENTRANT
// #cgo LDFLAGS: -lm -lpthread
// #cgo linux CPPFLAGS: -D_GNU_SOURCE
// #cgo darwin CFLAGS: -Idarwin_includes/internal/include -Idarwin_includes/internal/include/jemalloc/internal -fno-omit-frame-pointer
// #cgo linux,musl CFLAGS: -Ilinux_musl_includes/internal/include -Ilinux_musl_includes/internal/include/jemalloc/internal
// #cgo linux,!musl CFLAGS: -Ilinux_glibc_includes/internal/include -Ilinux_glibc_includes/internal/include/jemalloc/internal
// #cgo freebsd CFLAGS: -Ifreebsd_includes/internal/include -Ifreebsd_includes/internal/include/jemalloc/internal
import "C"
