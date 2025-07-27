#!/usr/bin/env bash
###############################################################################
##
##       filename: build.sh
##    description:
##        created: 2025/07/27
##         author: ticktechman
##
###############################################################################

set -e

get_archlinux() {
  wget https://ca.us.mirror.archlinuxarm.org/os/multi/ArchLinuxARM-2023.03-aarch64-rootfs.tar.gz
}

prepare_root() {
  truncate -s 10G root.img
  mkfs.ext4 -F root.img
  mkdir root
  sudo mount ./root.img ./root
}

build_root() {
  sudo tar zxf ArchLinuxARM-2023.03-aarch64-rootfs.tar.gz -C ./root
  cp ./root/boot/Image ./vmlinux
  sudo cp ./root/boot/initramfs-linux.img ./initrd.img
  sudo chmod a+r initrd.img
}

all_done() {
  sudo umount ./root
}

get_archlinux
prepare_root
build_root
all_done
###############################################################################
