#!/bin/sh

xhost +local:user
docker run -it \
    --runtime=nvidia \
    --rm \
    --env="DISPLAY" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="QT_X11_NO_MITSHM=1" \
    --name azure_kinect \
    --net host \
    --privileged \
    --env ROS_MASTER_URI=${ROS_MASTER_URI} \
    --env ROS_IP=${ROS_IP} \
    -v "/etc/localtime:/etc/localtime:ro" \
    -v "/$(pwd)/ros_packages/Azure_Kinect_ROS_Driver:/home/catkin_ws/src/Azure_Kinect_ROS_Driver" \
    azure_kinect:latest \
    bash -c "/bin/bash /catkin_build.bash && source /home/catkin_ws/devel/setup.bash && roslaunch azure_kinect_ros_driver driver.launch tf_prefix:=azure_kinect_"
  
