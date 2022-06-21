# Download
cd ~/
cd ..
cd /tmp
CERES_VERSION="ceres-solver-2.1.0"
CERES_ARCHIVE="$CERES_VERSION.tar.gz"
wget http://ceres-solver.org/$CERES_ARCHIVE
tar xfv $CERES_ARCHIVE

# Install
cd $CERES_VERSION
mkdir build
cd build
cmake ..
cmake --build . -j2

cd ../../../    

cd /tmp
wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.2.0.zip
wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.2.0.zip
unzip opencv.zip
unzip opencv_contrib.zip

cd opencv-3.2.0/
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=OFF -DENABLE_PRECOMPILED_HEADERS=OFF -D WITH_IPP=OFF -D WITH_1394=OFF -D BUILD_WITH_DEBUG_INFO=OFF -D BUILD_DOCS=OFF -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D ENABLE_NEON=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-3.2.0/modules -D WITH_V4L=ON -D WITH_FFMPEG=ON -D WITH_XINE=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D PYTHON_INCLUDE_DIR=/usr/include/python2.7 -D PYTHON_INCLUDE_DIR2=/usr/include/x86_64-linux-gnu/python2.7 -D PYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython2.7.so ../ -DBUILD_opencv_viz=OFF -DWITH_VTK=OFF
make -j2
sudo make install

cd ../../../

cd home
echo "check_certificate = off" >> ~/.wgetrc
wget https://github.com/Kitware/CMake/releases/download/v3.16.2/cmake-3.16.2.tar.gz
tar -xvzf cmake-3.16.2.tar.gz
rm cmake-3.16.2.tar.gz
cd cmake-3.16.2
./bootstrap
make -j2
make install
apt-get install -y apt-utils

