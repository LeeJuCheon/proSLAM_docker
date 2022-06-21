echo "== Install CMake Latest version == "
cd home
echo "check_certificate = off" >> ~/.wgetrc
wget https://github.com/Kitware/CMake/releases/download/v3.20.0/cmake-3.20.0.tar.gz
tar -xvzf cmake-3.20.0.tar.gz
rm cmake-3.20.0.tar.gz
cd cmake-3.20.0
./bootstrap
make -j3
make install
