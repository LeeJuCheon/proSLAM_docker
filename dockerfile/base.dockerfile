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
apt-get clean

RUN pip3 install pyyaml
RUN pip3 install gitpython

RUN apt-get autoclean



# ROS Package
RUN sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \ 
apt-get install curl && \
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add - && \
apt-get update -y && apt-get upgrade -y && \
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
apt-get install -y ros-melodic-desktop-full && \
apt-get install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential

RUN apt-get install python-catkin-tools -y

# DISPLAY 환경 설정
ENV DISPLAY=host.docker.internal:0.0

# RUN git clone https://github.com/yorsh87/g2o_catkin.git && \
# cd g2o_catkin && \
# mkdir build && \
# cd build && \
# cmake -DGIT_TAG=61ad5f87abf21b37fcb87d6343bab2512e58712d

# # Qt Install
# RUN apt-get install qt5-default && \ 
# apt-get install libfontconfig1 -y

# RUN mkdir slam && cd slam && \
#     git clone https://github.com/LeeJuCheon/ORB_SLAM3 && \
#     cd ORB_SLAM3 && python3 ./buildDeps.py --d --system

# RUN cd slam && cd ORB_SLAM3 && chmod +x build_thirdparty.sh && chmod +x build.sh\
#     ./build_thirdparty.sh
