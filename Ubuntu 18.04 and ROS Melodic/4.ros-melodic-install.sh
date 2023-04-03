echo -e "\e[1;92mAdd ROS Source..."
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
echo -e "\e[1;92mInstall ROS Melodic..."
sudo apt update && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
read -p "Please Input Install Type(core\full):" s
case $s in
    core)
        echo -e "\e[1;92mInstall ROS Core Function..."
        sudo apt install ros-melodic-ros-base
        ;;
    full)
        echo -e "\e[1;92mInstall ROS Desktop Pack with Full Function..."
        sudo apt install ros-melodic-desktop-full
        ;;
    *)
        echo -e "\e[1;92mInput Error\nPlease input core\\full..."
esac
echo -e "\e[1;92mSetup ROS Environment..."
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc
sudo rosdep init
rosdep update
echo -e "\e[1;92mFinished!"
