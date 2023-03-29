echo -e "\e[1;92mDownload Kernel and patch..."
sudo mkdir /usr/src/rt-preempt-linux
cd /usr/src/rt-preempt-linux
sudo wget https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.4.230.tar.gz
sudo wget https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.230-rt80.patch.gz
sudo tar -xzvf linux-5.4.230.tar.gz
sudo gunzip patch-5.4.230-rt80.patch.gz
sudo apt install -y libncurses5-dev flex bison cmake libssl-dev libelf-dev
sudo cp patch-5.4.230-rt80.patch linux-5.4.230/
cd /usr/src/rt-preempt-linux/linux-5.4.230
sudo patch -p1 < patch-5.4.230-rt80.patch
echo -e "\e[1;92mConfigure Kernel Build Parameters..."
sudo make mrproper
sudo cp /boot/config-5.4.0-1-generic .config
sudo make menuconfig
echo -e "\e[1;92mBuild Kernel and install..."
sudo make -j$(nproc)
sudo make modules_install
sudo make install
cd /boot
sudo mkinitramfs -k -o initrd.img-5.4.230-rt80 5.4.230-rt80
sudo update-grub
echo -e "\e[1;92mFinished!"
