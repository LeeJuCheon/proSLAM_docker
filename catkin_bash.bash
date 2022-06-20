echo "catkin_init_workspace"
mkdir -p ~/catkin_ws/src 
cd ~/catkin_ws/src 
catkin_init_workspace

echo "g2o_catkin"
cd ~/catkin_ws/src
git clone https://github.com/yorsh87/g2o_catkin.git
cd ..
catkin build g2o_catkin

echo "buildDeps.py"
cd ~/catkin_ws/src
git clone https://github.com/LeeJuCheon/proSLAM_docker.git
cd proSLAM_docker
python3 ./buildDeps.py --d --system
chmod +x ./pull_srrg_packages.bash
./pull_srrg_packages.bash
cd .. 
catkin build srrg_proslam
catkin build --make-args tests -- srrg_proslam