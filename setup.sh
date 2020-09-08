#!/bin/bash

# setup git
if [ -z "$1" ] && [ -z "$2" ]; then
    USERNAME=$(git config --list | awk -F= '$1=="user.name"{print $2}')
    read -e -p "git user.name [${USERNAME}]: " name && USERNAME=${name:-${USERNAME}}

    USEREMAIL=$(git config --list | awk -F= '$1=="user.email"{print $2}')
    read -e -p "git user.email [${USEREMAIL}]: " mail && USEREMAIL=${mail:-${USEREMAIL}}
else
    USERNAME=$1
    USEREMAIL=$2
fi

if [ -z ${USERNAME} ]; then echo "git user.name must not be empty" && exit 1; fi
if [ -z ${USEREMAIL} ]; then echo "git user.email must not be empty" && exit 1; fi

echo "setting up git ... " && \
git config --global user.name $USERNAME && \
git config --global user.email $USEREMAIL && \
git config --global color.ui false && \
echo SUCCESS || exit $?

# patch sshd to enable passwd login and restart sshd
echo "enabling password login for sshd ... " && \
sed 's/#\?\(PasswordAuthentication\s*\).*$/\1 yes/' /etc/ssh/sshd_config > /tmp/sshd_config && \
sudo mv -f /tmp/sshd_config /etc/ssh/sshd_config && \
sudo systemctl restart ssh && \
echo SUCCESS || exit $?

# install dependencies
echo "installing dependencies ... " && \
sudo dpkg --add-architecture i386 && \
sudo apt-get update && sudo apt-get upgrade -y && \
sudo apt-get -y install android-tools-adb android-tools-fastboot autoconf \
        automake bc bison build-essential ccache cscope curl device-tree-compiler \
        expect flex ftp-upload gdisk iasl libattr1-dev libc6:i386 libcap-dev \
        libfdt-dev libftdi-dev libglib2.0-dev libhidapi-dev libncurses5-dev \
        libpixman-1-dev libssl-dev libstdc++6:i386 libtool libz1:i386 make \
        mtools netcat python-crypto python3-crypto python-pyelftools \
        python3-pycryptodome python3-pyelftools python-serial python3-serial \
        rsync unzip uuid-dev xdg-utils xterm xz-utils zlib1g-dev libcap-ng-dev \
        libattr1-dev make repo && \
echo SUCCESS || exit $?

# install go
echo "installing go ... " && \
cd $HOME && \
wget https://golang.org/dl/go1.15.1.linux-amd64.tar.gz && \
sudo tar -C /usr/local -xzf go1.15.1.linux-amd64.tar.gz && \
rm go1.15.1.linux-amd64.tar.gz && \
echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.profile && \
source $HOME/.profile && \
echo SUCCESS || exit $?

# get optee sources for qemu arm 32bit
echo "getting optee ... " && \
mkdir -p $HOME/optee/qemu && \
cd $HOME/optee/qemu && \
repo init -u https://github.com/OP-TEE/manifest.git -b 3.10.0 && \
sudo cp $HOME/optee/qemu/.repo/repo/repo /usr/bin/repo && \
repo sync && \
echo SUCCESS || exit $?

# change the terminal settings for qemu host, REE and TEE to telnet so that
# terminals can be connected without graphical user interface
echo "patching optee ... " && \
cd build && \
patch -p1 < ../../fixes.patch && \
echo SUCCESS || exit $?

# install the arm toolchains
echo "installing arm toolchain ... " && \
make toolchains -j2 && \
echo 'export PATH=$PATH:$HOME/optee/qemu/toolchains/aarch32/bin' >> $HOME/.profile && \
echo 'export PATH=$PATH:$HOME/optee/qemu/toolchains/aarch64/bin' >> $HOME/.profile && \
source $HOME/.profile && \
echo SUCCESS || exit $?

# build all
echo "building ... " && \
make -C $HOME/optee/qemu/build \
    QEMU_USERNET_ENABLE=y \
    QEMU_VIRTFS_ENABLE=y \
    QEMU_VIRTFS_HOST_DIR=$HOME/optee/cryptoapi \
    QEMU_VIRTFS_MOUNTPOINT=/root \
    QEMU_VIRTFS_AUTOMOUNT=y all && \
make -C $HOME/optee/qemu/optee_os \
    CFG_TEE_BENCHMARK=n \
    CFG_TEE_CORE_LOG_LEVEL=3 \
    CROSS_COMPILE=arm-linux-gnueabihf- \
    CROSS_COMPILE_core=arm-linux-gnueabihf- \
    CROSS_COMPILE_ta_arm32=arm-linux-gnueabihf- \
    CROSS_COMPILE_ta_arm64=aarch64-linux-gnu- \
    DEBUG=1 \
    O=out/arm \
    PLATFORM=vexpress-qemu_virt V=1 && \
make -C $HOME/optee/qemu/optee_client V=1 && \
make -C $HOME/optee/cryptoapi all V=1 && \
echo SUCCESS || exit $?

cd $HOME && \
echo "DONE"
