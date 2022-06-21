echo "== Install ROS melodic == "
sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
apt install curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
apt update
apt install ros-melodic-desktop-full -y
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
. ~/.bashrc
apt install python-rosdep -y
apt install python-rosinstall -y
apt install python-rosinstall-generator -y
apt install python-wstool -y
apt install build-essential -y
rosdep update