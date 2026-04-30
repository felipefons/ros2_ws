#!/usr/bin/env bash

MODE=$1
shift

# ---- Detect GPU ----
if command -v nvidia-smi &> /dev/null; then
    echo "NVIDIA GPU detected → enabling NVIDIA runtime"
    GPU_FLAGS="--gpus all"
else
    echo "No NVIDIA GPU → using CPU/mesa rendering"
    GPU_FLAGS="--device=/dev/dri"
fi

# ---- Allow X11 ----
xhost +SI:localuser:$(whoami)

# -------------------------
run_px4() {
    IMAGE="fefon934/px4-gz:latest"

    docker run -it --rm \
      --net=host \
      --ipc=host \
      -e DISPLAY=$DISPLAY \
      -v /tmp/.X11-unix:/tmp/.X11-unix \
      -v /dev/shm:/dev/shm \
      $IMAGE \
      px4
}

# -------------------------
run_ros() {
    IMAGE="fefon934/ros2-jazzy-mavros:latest"

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
      $IMAGE \
      bash -c "
        source /opt/ros/jazzy/setup.bash &&
        cd /ros2_ws &&
        ${*:-bash}
      "
}

# -------------------------
case "$MODE" in
  px4)
    PX4_CMD=${PX4_CMD:-"px4"}
    run_px4
    ;;
  ros)
    run_ros "$@"
    ;;
  custom)
    PX4_CMD=${PX4_CMD:-"px4"}
    run_px4
    ;;
esac