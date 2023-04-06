#!/bin/bash
echo -e "\e[1;92mAdd PPA Source..."
sudo add-apt-repository -y ppa:up-division/5.4-upboard
echo -e "\e[1;92mRemove Old Kernel..."
sudo apt-get autoremove -y --purge 'linux-.*generic'
echo -e "\e[1;92mIntall New Kernel..."
sudo apt-get install -y linux-generic-hwe-18.04-5.4-upboard
echo -e "\e[1;92mIntall Update..."
sudo apt dist-upgrade -y
echo -e "\e[1;92mUpdate Grub..."
sudo update-grub
uname -a
echo -e "\e[1;92mFinished!"
