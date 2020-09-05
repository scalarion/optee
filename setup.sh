#!/bin/bash

USERNAME=$(git config --list | awk -F= '$1=="user.name"{print $2}')
read -e -p "git user.name [${USERNAME}]: " name && USERNAME=${name:-${USERNAME}}
if [ -z ${USERNAME} ]; then echo "git user.name must not be empty" && exit 0; fi

USEREMAIL=$(git config --list | awk -F= '$1=="user.email"{print $2}')
read -e -p "git user.email [${USEREMAIL}]: " mail && USEREMAIL=${mail:-${USEREMAIL}}
if [ -z ${USEREMAIL} ]; then echo "git user.email must not be empty" && exit 0; fi

git config --global user.name $USERNAME
git config --global user.email $USEREMAIL

sudo dpkg --add-architecture i386

sudo apt-get update

sudo apt-get -y install android-tools-adb android-tools-fastboot autoconf \
        automake bc bison build-essential ccache cscope curl device-tree-compiler \
        expect flex ftp-upload gdisk iasl libattr1-dev libc6:i386 libcap-dev \
        libfdt-dev libftdi-dev libglib2.0-dev libhidapi-dev libncurses5-dev \
        libpixman-1-dev libssl-dev libstdc++6:i386 libtool libz1:i386 make \
        mtools netcat python-crypto python3-crypto python-pyelftools \
        python3-pycryptodome python3-pyelftools python-serial python3-serial \
        rsync unzip uuid-dev xdg-utils xterm xz-utils zlib1g-dev make repo

mkdir -p ~/optee/qemu
cd ~/optee/qemu
repo init -u https://github.com/OP-TEE/manifest.git -b 3.10.0
sudo cp ~/optee/qemu/.repo/repo/repo /usr/bin/repo
repo sync
cd build
make toolchains -j2
make run -j `npro`
