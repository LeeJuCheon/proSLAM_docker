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
apt-get install libgflags-dev -y && \
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

RUN cd ~/catkin_ws/src/proSLAM_docker && \
chmod +x ROS_bash.sh && \
./ROS_bash.sh

# RUN cd ~/ &&  cd .. && \ 
# wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.2.0.zip && \ 
# wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.2.0.zip && \ 
# apt-get install unzip && \ 
# unzip opencv.zip && \  
# unzip opencv_contrib.zip && \  
# cd opencv-3.2.0/ && \  
# mkdir build && \ 
# cd build && \ 
# cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=OFF -D ENABLE_PRECOMPILED_HEADERS=OFF -D WITH_IPP=OFF -D WITH_1394=OFF -D BUILD_WITH_DEBUG_INFO=OFF -D BUILD_DOCS=OFF -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D ENABLE_NEON=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.2.0/modules -D WITH_V4L=ON -D WITH_FFMPEG=ON -D WITH_XINE=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D PYTHON_INCLUDE_DIR=/usr/include/python2.7 -D PYTHON_INCLUDE_DIR2=/usr/include/x86_64-linux-gnu/python2.7 -D PYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython2.7.so ../ -DBUILD_opencv_viz=OFF -DWITH_VTK=OFF && \ 
# make -j2 && \ 
# sudo make install

RUN cd ~/catkin_ws/src/proSLAM_docker && \
chmod +x catkin_bash.sh && \
./catkin_bash.sh

RUN cd ~/catkin_ws/src/proSLAM_docker && \
chmod +x modify_bash.sh && \
./modify_bash.sh


# DISPLAY ?????? ??????
ENV DISPLAY=host.docker.internal:0.0
