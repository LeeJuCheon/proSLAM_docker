FROM proslam:test

ARG BRANCH=main
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get upgrade -y

RUN useradd -m user && yes password | passwd user

RUN cd ~/catkin_ws/src/proSLAM_docker && \
git remote update && \
git fetch --all && \
git checkout ${BRANCH} && \
git pull

RUN apt-get purge --auto-remove cmake

RUN cd ~/catkin_ws/src/proSLAM_docker && \
chmod +x catkin_bash.sh && \
./catkin_bash.sh

# RUN chmod +x ~/.bashrc && \ 
# ~/.bashrc -c '. /opt/ros/melodic/setup.bash; cd ~/catkin_ws/src; catkin_init_workspace'

# RUN /bin/bash -c '. /opt/ros/melodic/setup.bash; cd ~/catkin_ws/src; catkin_init_workspace'

# RUN cd ~/catkin_ws/src&& \
# git clone https://github.com/yorsh87/g2o_catkin.git && \
# cd .. && \
# catkin build g2o_catkin 

# RUN cd ~/catkin_ws/src && \
# git clone https://github.com/LeeJuCheon/proSLAM_docker.git && \
# cd proSLAM_docker && \
# python3 ./buildDeps.py --d --system && \
# chmod +x ./pull_srrg_packages.bash && \
# ./pull_srrg_packages.bash
#catkin build --make-args tests -- srrg_proslam


# git branch && \
# git branch && \
# mkdir build && \
# cd build && \
# cmake .. -DCMAKE_BUILD_TYPE=Release && \
# make -j2


# RUN echo "== Start Debug build == " && \
# cd slam && cd ORB_SLAM3 && \
# git remote update && \
# git fetch --all && \
# git checkout ${BRANCH} && \
# git pull && \
# git branch && \
# cd build && \
# cmake .. -DCMAKE_BUILD_TYPE=Debug && \
# make -j2


