## Build New Linux Kernel Designed for UPSquared with Ubuntu 20.04.6 LTS

- Create Workspace:

        sudo mkdir /usr/src/rt-preempt-linux

- Download Kernel and Patch from Kernel Website:

        https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/
        https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/5.15/

    ***Select Matched version of Kernel and Patch is very important***

    For example, we download Version 5.15.96 here.

        https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.15.96.tar.gz
        https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.96-rt61.patch.gz

- Copy Kernel and Patch to Workspace and Unzip them:

        sudo cp ~/linux-5.15.96.tar.gz /usr/src/rt-preempt-linux
        sudo cp ~/patch-5.15.96-rt61.patch.gz /usr/src/rt-preempt-linux
        sudo tar -xzvf linux-5.15.96.tar.gz
        sudo gunzip patch-5.15.96-rt61.patch.gz

- Install Necessary Tools, Libraries and Apply Patch:

        cd /usr/bin
        sudo ln -s objdump nobjdump
        sudo ln -s ld nld
        sudo apt install libncurses5-dev flex bison cmake libssl-dev libelf-dev zstd binutils dwarves fakeroot
        sudo cp patch-5.15.96-rt61.patch linux-5.15.96/
        cd /usr/src/rt-preempt-linux/linux-5.15.96
        sudo patch -p1 < patch-5.15.96-rt61.patch

- Configure Kernel Compile Parameters:

        sudo make mrproper
        sudo cp /boot/config-5.15.0-1026-intel-iotg .config
        sudo make menuconfig

    - Select "General setup > Preemption Model" Option, Choose "Fully Preemptible Kernel(Real-Time)" Option
    - Select "Processor type and features > Timer frequency" Option, Choose "1000 HZ" Option
    - Select "Device Drivers" Option, De-select "Staging drivers" Option
    - Select "Binary Emulations" Option, De-select "x32 ABI for 64-bit mode" Option
    - Select "Kernel hacking > Compile-time checks and compiler options" Option, De-select "Compile the kernel with debug info" Option
    - Select "Cryptographic API > Certificates for signature checking" Option, Set "Additional X.509 keys for default system keyring" to blank
    - Select "Cryptographic API > Certificates for signature checking" Option, Set "X.509 certificates to be preloaded into the system blacklist keyring" to blank
    - Exit Configure Menu, All Modifications are Auto-Saved to .config File

- Compile Kernel:

    *"n" Means Compile jobs in Parallel*

        sudo make -j$(nproc)

- Install New Compiled Kernel:

        sudo make INSTALL_MOD_STRIP=1 modules_install
        sudo make bzImage
        sudo make install
        cd /boot
        sudo mkinitramfs -k -o initrd.img-5.15.96-rt61 5.15.96-rt61

- Update GRUB Boot Options:

        sudo update-grub

- Reboot the UPSquared:

        sudo init 6

- Verify if kernel is updated Correctly:

    *Kernel Version Should Changed to 5.15.96-rt61*

        uname -a
