echo -e "\e[1;92mInstall Dependent Software Packages..."
sudo apt update && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt install -y ros-melodic-soem ros-melodic-gazebo-ros-control ros-melodic-ros-control ros-melodic-ros-controllers
sudo apt install -y ros-melodic-moveit-*
sudo apt install -y ros-melodic-trac-ik
echo -e "\e[1;92mCreate catkin Workspace..."
source /opt/ros/melodic/setup.bash
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
catkin_make
echo -e "\e[1;92mBuild and Configure Elfin Robot Control Software..."
cd ~/catkin_ws/src
git clone -b melodic-devel https://github.com/hans-robot/elfin_robot.git
cd ..
catkin_make
source devel/setup.bash
