## Install ROS Noetic

- Add ROS Source:

        sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
        curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

- Install ROS Noetic Full for Test Use or for RViZ Graphical Interaction:

        sudo apt update && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
        sudo apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
        sudo apt install -y ros-noetic-desktop-full

- Install ROS Noetic Bare Bones for ROS Master Node or any other Nodes without Graphical Requirements:

        sudo apt update && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
        sudo apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
        sudo apt install -y ros-noetic-desktop-base

- Setup ROS Environment:

        echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
        source ~/.bashrc
        sudo rosdep init
        rosdep update
