echo -e "\e[1;92mUpdate System..."
sudo apt update && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
echo -e "\e[1;92mInstall Packages..."
sudo apt install -y git nano curl wget openssh-server net-tools tree htop screen tmux
echo -e "\e[1;92mInstall Ubuntu-Desktop..."
sudo apt install -y ubuntu-desktop
echo -e "\e[1;92mFinished!"
