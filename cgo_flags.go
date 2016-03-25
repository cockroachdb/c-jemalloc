// Package jemalloc uses the cgo compilation facilities to build the
// jemalloc library.
package jemalloc

// #cgo CFLAGS: -Iinternal/include
// #cgo linux CFLAGS: -DJEMALLOC_PURGE_MADVISE_DONTNEED
// #cgo darwin CFLAGS: -DJEMALLOC_OSATOMIC -DJEMALLOC_OSSPIN -DJEMALLOC_PURGE_MADVISE_FREE -DJEMALLOC_HAVE_ISSETUGID
// #cgo darwin CFLAGS: -DJEMALLOC_ZONE -DJEMALLOC_ZONE_VERSION=8
// #cgo LDFLAGS: -Wl,-undefined -Wl,dynamic_lookup -lm
import "C"
