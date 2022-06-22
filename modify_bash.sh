echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
. ~/.bashrc

touch /etc/ld.so.conf.d/g2o.conf
echo "/root/catkin_ws/devel/lib" >> /etc/ld.so.conf.d/g2o.conf

echo "catkin_init_workspace"
cd ~/catkin_ws/src 
catkin_init_workspace

echo "g2o_catkin"
cd ~/catkin_ws/src
git clone https://github.com/yorsh87/g2o_catkin.git
cd ..
catkin build g2o_catkin

cd ~/catkin_ws/src
cd proSLAM_docker
chmod +x ./pull_srrg_packages.bash
./pull_srrg_packages.bash
cd .. 
catkin build --make-args tests -- srrg_proslam
catkin build srrg_proslam
