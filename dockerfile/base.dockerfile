FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN sed -i 's@archive.ubuntu.com@mirror.kakao.com@g' /etc/apt/sources.list
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install build-essential -y && \

# Related to proSLAM
apt-get install libeigen3-dev -y && \
apt-get install libsuitesparse-dev -y && \
apt-get install freeglut3-dev -y && \
apt-get install libqglviewer-dev-qt5 -y && \
apt-get install libyaml-cpp-dev -y && \
apt-get install ninja-build -y && \

# Related to build...
apt-get install cmake -y && \
apt-get install git -y && \
apt-get install sudo -y && \
apt-get install wget -y && \
apt-get install ninja-build -y && \
apt-get install software-properties-common -y && \
apt-get install python3 -y && \
apt-get install python3-pip -y && \

# Related to JetBrains CLion Docker develpoment...

apt-get install -y ssh && \
apt-get install -y gcc && \
apt-get install -y g++ && \
apt-get install -y gdb && \
apt-get install -y clang && \
apt-get install -y cmake && \
apt-get install -y rsync && \
apt-get install -y tar && \
apt-get install -y mesa-utils && \
apt-get install -y libpython2.7-dev && \

# Related to X11 remote display
apt-get install -y libgl1-mesa-glx && \
apt-get install -y libglu1-mesa-dev && \
apt-get install -y mesa-common-dev && \
apt-get install -y x11-utils && \
apt-get install -y x11-apps && \
apt-get install x11-xserver-utils && \
apt-get install libssl-dev -y && \
apt-get clean
 
RUN pip3 install pyyaml
RUN pip3 install gitpython

RUN apt-get autoclean

RUN apt-get install qt5* -y

RUN echo "Configuring and building Thirdparty/OpenSSL ..." && \
wget https://www.openssl.org/source/openssl-1.1.1i.tar.gz && \
tar xvfz openssl-1.1.1i.tar.gz && \
cd openssl-1.1.1i/ && \
./config shared && \
make && \
make install && \
ldconfig 

RUN mkdir -p ~/catkin_ws/src && \
cd ~/catkin_ws/src && \
git clone https://github.com/LeeJuCheon/proSLAM_docker.git

RUN cd ~/catkin_ws/src/proSLAM_docker && \
chmod +x cmake_bash.sh && \
./cmake_bash.sh

# ROS Package
RUN ~/catkin_ws/src/proSLAM_docker && \
chmod +x ./ROS_bash.sh && \
./ROS_bash.sh

RUN cd ~/catkin_ws/src/proSLAM_docker && \
chmod +x catkin_bash.sh && \
./catkin_bash.sh



# Ceres-solver 2.1.0

# OpenCV 3.2.0


# CMD cd root/ && echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc && \
# rosdep update && \
# mkdir -p ~/catkin_ws/src && \
# cd ~/catkin_ws/src && \
# catkin_init_workspace

# RUN cd ~/catkin_ws/src && \ 
# git clone https://github.com/yorsh87/g2o_catkin.git && \
# cd .. && \ 
# catkin build g2o_catkin

# RUN cd ~/catkin_ws/src && \
# git clone https://github.com/LeeJuCheon/proSLAM_docker.git && \
# cd src/proSLAM_docker && \
# chmod +x ./pull_srrg_packages.bash && \
# ./pull_srrg_packages.bash && \ 
# python3 ./buildDeps.py --d --system && \
# cd .. && \ 
# catkin build --make-args tests -- srrg_proslam && \ 
# catkin build srrg_proslam 

# DISPLAY 환경 설정
ENV DISPLAY=host.docker.internal:0.0
