// Package jemalloc uses the cgo compilation facilities to build the
// jemalloc library.
package jemalloc

// #cgo CFLAGS: -Iinternal/include
// #cgo darwin CFLAGS: -Idarwin_includes/internal/include -Idarwin_includes/internal/include/jemalloc/internal
// #cgo linux CFLAGS: -Ilinux_includes/internal/include -Ilinux_includes/internal/include/jemalloc/internal
// #cgo LDFLAGS: -lm
import "C"
