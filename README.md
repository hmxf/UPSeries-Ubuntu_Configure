# UPSquared ROS Melodic Install Guide

This Document is a UPSquared ROS Melodic Install Guide from BareMetal.

Scripts are Used for Quick Configure.

**READ THEM BEFORE EXECUTE**

Execute them in Order after your Modification.

Every Script Ends with a Reboot Operation, so REBOOT your board when you see "Finished!"

## Flash System Image

- Choose Ubuntu 18.04.6 LTS for combination use with ROS Melodic.
- Download and Flash System Image to USB Thumbdrive.

## System Flashing and Pre-configure

- Connect Display, Network and Keyboard Cable to UPSquared.
- Connect USB Thumbdrive with System Image and then Power on UPSquared.
- If you want to change BIOS settings of UPSquared, press DEL before LOGO vanished.
- BIOS Password is empty, when asked, just press ENTER.
- Install System with steps the same as what you were doing on PC or Server.
- After install, install Updates and tools:

        sudo apt update && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
        sudo apt install -y git nano curl wget openssh-server net-tools tree htop screen tmux

- Install Ubuntu-desktop for Graphic Uses:

        sudo apt install -y ubuntu-desktop

- Reboot the UPSquared:

        sudo init 6

## Install New Linux Kernel Designed for UPSquared

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

    - Select "General setup > Preemption Model" Option
    - Choose "Fully Preemptible Kernel(Real-Time)" Option
    - Back to Top Level Menu
    - Select "Device Drivers" Option
    - De-select "Staging drivers" Option
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

## Install ROS Melodic

- Add ROS Source:

        sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
        curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

- Install ROS Melodic Full for Test Use or for RViZ Graphical Interaction:

        sudo apt update && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
        sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
        sudo apt install ros-melodic-desktop-full

- Install ROS Melodic Bare Bones for ROS Master Node or any other Nodes without Graphical Requirements:

        sudo apt update && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
        sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
        sudo apt install ros-melodic-ros-base

- Setup ROS Environment:

        echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
        source ~/.bashrc
        sudo rosdep init
        rosdep update

## Install Elfin Robot Control Software

- Install Dependent Software Packages:

        sudo apt update && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
        sudo apt install -y ros-melodic-soem ros-melodic-gazebo-ros-control ros-melodic-ros-control ros-melodic-ros-controllers
        sudo apt install -y ros-melodic-moveit-*
        sudo apt install -y ros-melodic-trac-ik

- Create catkin Workspace:

        source /opt/ros/melodic/setup.bash
        mkdir -p ~/catkin_ws/src
        cd ~/catkin_ws/
        catkin_make

- Build and Configure Elfin Robot Control Software:

        cd ~/catkin_ws/src
        git clone -b melodic-devel https://github.com/hans-robot/elfin_robot.git
        cd ..
        catkin_make
        source devel/setup.bash

## Operate Elfin Robot through Gazebo Simulation and Real Hardware

- Gazebo Simulation for Elfin Robot:

        roslaunch elfin_gazebo elfin3_empty_world.launch
        roslaunch elfin3_moveit_config moveit_planning_execution.launch
        roslaunch elfin_basic_api elfin_basic_api.launch

- Real Hardware Configurations of Elfin Robot:

    Check if this File is Exist:

        ~/catkin_ws/src/elfin_robot/elfin_robot_bringup/config/elfin_drivers.yaml

    If Exist, Modify Content as Instructions [Here](https://github.com/hans-robot/elfin_robot/blob/melodic/elfin_robot_bringup/config/elfin_drivers.yaml).
    
    If not Exist, Download this File from Above Link and make Modifications.

    There are 3 Places Need to be Modified in General:

    - Modify Network name as your Platform's *ifconfig* Output and your Physical Connect Format.

            elfin_ethernet_name: eth0

    - Modify Reduction Ratio as your Elfin Robot's Product Model:

            reduction_ratios: [101, 101, 101, 101, 101, 101]

    - Modify Zero Points of Each Joint as your Elfin Robot's Test Report:

            count_zeros: [8907490, 9037465, 5336080, 5456119, 4246746, 1592228]

- Real Hardware Operate Instructions of Elfin Robot with RS485 Protocol:

        roslaunch elfin_robot_bringup elfin3_bringup.launch
        sudo chrt 10 bash
        roslaunch elfin_robot_bringup elfin_ros_control_v3.launch
        roslaunch elfin3_moveit_config moveit_planning_execution.launch
        roslaunch elfin_basic_api elfin_basic_api.launch

    Tips:

    Enable the servos of Elfin with "Elfin Control Panel" interface.
    
    If there is no "Warning", Press the "Servo On" Button to Enable the Robot.
    
    If there is "Warning", Press the "Clear Fault" Button first and then Press the "Servo On" Button.

    **Every time you want to Plan a Trajectory, the Start State should be Set to Current FIRST, [Here](https://github.com/hans-robot/elfin_robot/blob/melodic/docs/moveit_plugin_tutorial_english.md) are some Reference Documents.**

    Before Turning the Robot Off, the "Servo Off" Button should be Pressed to Disable the Robot.