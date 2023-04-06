## Install New Linux Kernel Designed for UPSquared with Ubuntu 18.04.6 LTS

- Add New PPA Source:

        sudo add-apt-repository -y ppa:up-division/5.4-upboard

- Remove Old Kernel:

    ***Select No on the question "Abort Kernel Removal"***

        sudo apt-get autoremove -y --purge 'linux-.*generic'

- Install New Kernel:

        sudo apt-get install -y linux-generic-hwe-18.04-5.4-upboard

- Install Updates:

        sudo apt dist-upgrade -y

- Update GRUB Boot Options:

        sudo update-grub

- Reboot the UPSquared:

        sudo init 6

- Verify if kernel is updated Correctly:

    *Kernel Version Should Changed to 5.4.0-1-generic*

        uname -a

## Patch Kernel for Preempt-RT Support

- Create Workspace:

        sudo mkdir /usr/src/rt-preempt-linux

- Download Kernel and Patch from Kernel Website:

        https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/
        https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/5.4/

    ***Select Matched version of Kernel and Patch is very important***

    For example, we download Version 5.4.230 here.

        https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.4.230.tar.gz
        https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.230-rt80.patch.gz

- Copy Kernel and Patch to Workspace and Unzip them:

        sudo cp ~/linux-5.4.230.tar.gz /usr/src/rt-preempt-linux
        sudo cp ~/patch-5.4.230-rt80.patch.gz /usr/src/rt-preempt-linux
        sudo tar -xzvf linux-5.4.230.tar.gz
        sudo gunzip patch-5.4.230-rt80.patch.gz

- Install Necessary Tools, Libraries and Apply Patch:

        sudo apt install libncurses5-dev flex bison cmake libssl-dev libelf-dev
        sudo cp patch-5.4.230-rt80.patch linux-5.4.230/
        cd /usr/src/rt-preempt-linux/linux-5.4.230
        sudo patch -p1 < patch-5.4.230-rt80.patch

- Configure Kernel Compile Parameters:

        sudo make mrproper
        sudo cp /boot/config-5.4.0-1-generic .config
        sudo make menuconfig

    - Select "General setup > Preemption Model" Option, Choose "Fully Preemptible Kernel(Real-Time)" Option
    - Select "Processor type and features > Timer frequency" Option, Choose "1000 HZ" Option
    - Select "Device Drivers" Option, De-select "Staging drivers" Option
    - Exit Configure Menu, All Modifications are Auto-Saved to .config File

- Compile Kernel:

    *"n" Means Compile jobs in Parallel*

        sudo make -j$(nproc)

- Install New Compiled Kernel:

        sudo make INSTALL_MOD_STRIP=1 modules_install
        sudo make install
        cd /boot
        sudo mkinitramfs -k -o initrd.img-5.4.230-rt80 5.4.230-rt80

- Update GRUB Boot Options:

        sudo update-grub

- Reboot the UPSquared:

        sudo init 6

- Verify if kernel is updated Correctly:

    *Kernel Version Should Changed to 5.4.230-rt80*

        uname -a
