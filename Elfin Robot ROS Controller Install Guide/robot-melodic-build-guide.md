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
