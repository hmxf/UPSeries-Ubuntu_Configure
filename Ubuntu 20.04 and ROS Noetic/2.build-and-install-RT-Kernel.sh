#!/bin/bash
echo -e "\e[1;92mDownload Kernel and patch..."
sudo mkdir /usr/src/rt-preempt-linux
cd /usr/src/rt-preempt-linux
sudo wget https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.15.96.tar.gz
sudo wget https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.96-rt61.patch.gz
sudo tar -xzvf linux-5.15.96.tar.gz
sudo gunzip patch-5.15.96-rt61.patch.gz
cd /usr/bin
sudo ln -s objdump nobjdump
sudo ln -s ld nld
sudo apt install libncurses5-dev flex bison cmake libssl-dev libelf-dev zstd binutils dwarves fakeroot
sudo cp patch-5.15.96-rt61.patch linux-5.15.96/
cd /usr/src/rt-preempt-linux/linux-5.15.96
sudo patch -p1 < patch-5.15.96-rt61.patch
echo -e "\e[1;92mConfigure Kernel Build Parameters..."
sudo make mrproper
sudo cp /boot/config-5.15.0-1026-intel-iotg .config
sudo make menuconfig
echo -e "\e[1;92mBuild Kernel and install..."
sudo make -j$(nproc)
sudo make INSTALL_MOD_STRIP=1 modules_install
sudo make bzImage
sudo make install
cd /boot
sudo mkinitramfs -k -o initrd.img-5.15.96-rt61 5.15.96-rt61
sudo update-grub
echo -e "\e[1;92mFinished!"
