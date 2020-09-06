#!/bin/bash

export QEMU_USERNET_ENABLE=y
export QEMU_VIRTFS_ENABLE=y  
export QEMU_VIRTFS_HOST_DIR=$HOME/optee/cryptoapi
export QEMU_VIRTFS_MOUNTPOINT=/root
export QEMU_VIRTFS_AUTOMOUNT=y

make -C $HOME/optee/qemu/build run-only
