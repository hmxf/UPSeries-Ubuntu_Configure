## Install Elfin Robot Control Software

- Install Dependent Software Packages:

      sudo apt update && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
      sudo apt install -y ros-noetic-soem ros-noetic-gazebo-ros-control ros-noetic-ros-control ros-noetic-ros-controllers
      sudo apt install -y ros-noetic-moveit
      sudo apt install -y ros-noetic-trac-ik

- Install and Set Python 3.8 for ROS Noetic.

      sudo apt install -y python3.8 pip
      cd /usr/bin
      sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 1
      sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 2
      sudo update-alternatives --config python

    Select Python 3.8 for ROS Noetic.

- Install Other Dependencies:

      sudo apt -y install build-essential libgtk-3-dev python3-catkin-tools
      pip3 install -U -f https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-20.04 wxPython

- Create catkin Workspace:

      source /opt/ros/noetic/setup.bash
      mkdir -p ~/catkin_ws/src
      cd ~/catkin_ws/
      catkin build

- Build and Configure Elfin Robot Control Software:

      cd ~/catkin_ws/src
      git clone -b noetic https://github.com/hans-robot/elfin_robot.git
      cd ..
      catkin build elfin_ethercat_driver
      catkin build
      source devel/setup.bash

## Operate Elfin Robot through Gazebo Simulation and Real Hardware

- Gazebo Simulation for Elfin Robot:

    - Terminal 1:

          roslaunch elfin_gazebo elfin5_empty_world.launch

    - Terminal 2:

          roslaunch elfin5_moveit_config moveit_planning_execution.launch

    - Terminal 3:

          roslaunch elfin_basic_api elfin_basic_api.launch

- Real Hardware Configurations of Elfin Robot:

    Check if this File is Exist:

      ~/catkin_ws/src/elfin_robot/elfin_robot_bringup/config/elfin_drivers.yaml

    If not Exist, Download this File from [Here](https://github.com/hans-robot/elfin_robot/blob/noetic/elfin_robot_bringup/config/elfin_drivers.yaml) and make Modifications.

    If Exist, Modify Content as Instructions below:

    There are 3 Places Need to be Modified in General:

    - Modify Network name as your Platform's *ifconfig* Output and your Physical Connect Format.

          elfin_ethernet_name: eth0

    - Modify Reduction Ratio as your Elfin Robot's Product Model:

          reduction_ratios: [101, 101, 101, 101, 101, 101]

    - Modify Zero Points of Each Joint in the order of [J2, J1, J3, J4, J5, J6] as your Elfin Robot's Test Report:

          count_zeros: [8907490, 9037465, 5336080, 5456119, 4246746, 1592228]

- Real Hardware Operate Instructions of Elfin Robot with RS485 Protocol:

    - Terminal 1:

          roslaunch elfin_robot_bringup elfin5_bringup.launch

    - Terminal 2:

          sudo chrt 10 bash
          source /opt/ros/noetic/setup.bash
          source /home/<YOUR_USER_NAME>/catkin_ws/devel/setup.bash
          roslaunch elfin_robot_bringup elfin_ros_control.launch

    - Terminal 3:

          roslaunch elfin5_moveit_config moveit_planning_execution.launch

    - Terminal 4:

          roslaunch elfin_basic_api elfin_basic_api.launch

    Tips:

    Enable the servos of Elfin with "Elfin Control Panel" interface.
    
    If there is no "Warning", Press the "Servo On" Button to Enable the Robot.
    
    If there is "Warning", Press the "Clear Fault" Button first and then Press the "Servo On" Button.

    **Every time you want to Plan a Trajectory, the Start State should be Set to Current FIRST, [Here](https://github.com/hans-robot/elfin_robot/blob/noetic/docs/moveit_plugin_tutorial_english.md) are some Reference Documents.**

    Before Turning the Robot Off, the "Servo Off" Button should be Pressed to Disable the Robot.
