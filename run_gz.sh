#!/usr/bin/env bash

IMAGE="fefon934/ros2-jazzy-gz:latest"

# Allow Docker to access display server (X11)
xhost +local:docker

# Pull the latest version of the Docker image from the repository
docker pull $IMAGE

# Detect NVIDIA GPU, if not available, use CPU rendering
if command -v nvidia-smi &> /dev/null; then
    echo "NVIDIA GPU detected → enabling NVIDIA runtime"
    GPU_FLAGS="--gpus all"
else
    echo "No NVIDIA GPU → using CPU/mesa rendering"
    GPU_FLAGS="--device=/dev/dri"
fi

# Run container with:
# - host networking (ROS2)
# - shared memory (Gazebo)
# - GPU access
# - X11 forwarding

docker run -it --rm \
  --net=host \
  --ipc=host \
  --user $(id -u):$(id -g) \
  $GPU_FLAGS \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -e QT_QPA_PLATFORM=xcb \
  -e NVIDIA_DRIVER_CAPABILITIES=all \
  -e XDG_RUNTIME_DIR=/tmp/runtime-docker \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /dev/shm:/dev/shm \
  -v ~/ros2_ws:/ros2_ws \
  $IMAGE

# Revoke permission after exit
xhost -local:docker