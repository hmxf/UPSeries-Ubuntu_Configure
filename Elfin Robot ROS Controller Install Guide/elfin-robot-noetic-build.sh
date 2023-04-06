#!/bin/bash
echo -e "\e[1;92mInstall and Set Python 3.8 for ROS Noetic..."
sudo apt install -y python3.8 pip
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 2
echo -e "\e[1;92mSelect Python 3.8 Manual Mode for ROS Noetic in Below Choices:"
sudo update-alternatives --config python
echo -e "\e[1;92mInstall Dependent Software Packages..."
sudo apt update && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt install -y ros-noetic-soem ros-noetic-gazebo-ros-control ros-noetic-ros-control ros-noetic-ros-controllers build-essential libgtk-3-dev
pip3 install -U -f https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-20.04 wxPython
sudo apt install -y ros-noetic-moveit
sudo apt install -y ros-noetic-trac-ik
echo -e "\e[1;92mCreate catkin Workspace..."
source /opt/ros/noetic/setup.bash
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
catkin_make
echo -e "\e[1;92mBuild and Configure Elfin Robot Control Software..."
cd ~/catkin_ws/src
git clone -b noetic https://github.com/hans-robot/elfin_robot.git
cd ..
catkin_make
source devel/setup.bash
