#!/usr/bin/env bash

IMAGE="fefon934/ros2-jazzy-full:latest"

# Allow Docker to access display
xhost +local:docker

# Pull latest image (optional but nice UX)
docker pull $IMAGE

# Run container
docker run -it --rm \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -e QT_QPA_PLATFORM=xcb \
  -e LIBGL_ALWAYS_SOFTWARE=1 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  $IMAGE

# Revoke permission after exit
xhost -local:docker