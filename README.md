# UPSquared Series RT Kernel and ROS Install Guide

This Document is a RT Kernel and ROS Install Guide from Bare Metal UPSquared Series Development Board.

Scripts should be Used for Documents' References.

**READ THEM BEFORE EXECUTE**

Execute them in Order after your Modification.

Every Script Ends with a Reboot Operation, so **REBOOT** your board when scripts ended its execution with a "Finished!" message.

## Flash System Image

- Choose [Ubuntu 18.04.6 LTS Image](https://releases.ubuntu.com/18.04.6/ubuntu-18.04.6-live-server-amd64.iso) for combination use with ROS Melodic.
- Choose [Ubuntu 20.04.5 LTS Image](https://cdimage.ubuntu.com/ubuntu-server/focal/daily-live/manual/focal-live-server-amd64+intel-iot.iso) for combination use with ROS Noetic.
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

## Select Correct Kernel Build Guide and Matched ROS Install Guide for Next Steps.

[Ubuntu 18.04.6 LTS RT Kernel Build and Install Guide](./Ubuntu%2018.04%20and%20ROS%20Melodic/ubuntu18.04-kernel-build-guide.md)

[ROS Melodic Install Guide for Ubuntu 18.04.6 LTS](./Ubuntu%2018.04%20and%20ROS%20Melodic/ros-melodic-install-guide.md)

[Ubuntu 20.04.5 LTS RT Kernel Build and Install Guide](./Ubuntu%2020.04%20and%20ROS%20Noetic/ubuntu20.04-kernel-build-guide.md)

[ROS Noetic Install Guide for Ubuntu 20.04.5 LTS](./Ubuntu%2020.04%20and%20ROS%20Noetic/ros-noetic-install-guide.md)

## Download and Build Control Software Source Code for Elfin Robot

[Elfin Robot use with ROS Melodic](./Elfin%20Robot%20ROS%20Controller%20Install%20Guide/robot-melodic-build-guide.md)

[Elfin Robot use with ROS Noetic](./Elfin%20Robot%20ROS%20Controller%20Install%20Guide/robot-noetic-build-guide.md)
