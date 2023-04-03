## Install ROS Melodic

- Add ROS Source:

        sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
        curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

- Install ROS Melodic Full for Test Use or for RViZ Graphical Interaction:

        sudo apt update && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
        sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
        sudo apt install -y ros-melodic-desktop-full

- Install ROS Melodic Bare Bones for ROS Master Node or any other Nodes without Graphical Requirements:

        sudo apt update && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
        sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
        sudo apt install -y ros-melodic-ros-base

- Setup ROS Environment:

        echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
        source ~/.bashrc
        sudo rosdep init
        rosdep update
