#!/bin/bash
echo -e "\e[1;92mDownload Kernel and patch..."
sudo mkdir /usr/src/rt-preempt-linux
cd /usr/src/rt-preempt-linux
sudo wget https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.15.177.tar.gz
sudo wget https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.177-rt83.patch.gz
sudo tar -xzvf linux-5.15.177.tar.gz
sudo gunzip patch-5.15.177-rt83.patch.gz
cd /usr/bin
sudo apt install libncurses5-dev flex bison cmake libssl-dev libelf-dev zstd binutils dwarves fakeroot
sudo ln -s objdump nobjdump
sudo ln -s ld nld
cd /usr/src/rt-preempt-linux
sudo cp patch-5.15.177-rt83.patch linux-5.15.177/
cd /usr/src/rt-preempt-linux/linux-5.15.177
sudo patch -p1 < patch-5.15.177-rt83.patch
echo -e "\e[1;92mConfigure Kernel Build Parameters..."
sudo make mrproper
sudo cp /boot/config-5.15.0-1073-intel-iotg .config
sudo make menuconfig
echo -e "\e[1;92mBuild Kernel and install..."
sudo make -j$(nproc)
sudo make INSTALL_MOD_STRIP=1 modules_install
sudo make bzImage
sudo make install
cd /boot
sudo mkinitramfs -k -o initrd.img-5.15.177-rt83 5.15.177-rt83
sudo update-grub
echo -e "\e[1;92mFinished!"
