# syntax=docker/dockerfile:1

FROM ros:jazzy-ros-base

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install basic development tools
RUN apt-get update && apt-get install -y \
    curl gnupg lsb-release && \
    curl -sSL https://packages.osrfoundation.org/gazebo.key | apt-key add - && \
    echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" \
    > /etc/apt/sources.list.d/gazebo-stable.list && \
    apt-get update && apt-get install -y --no-install-recommends \
    locales \
    build-essential \
    git \
    python3-pip \
    python3-colcon-common-extensions \
    ros-jazzy-desktop \
    ros-jazzy-ros-gz \
    ros-jazzy-ros-gz-sim \
    ros-jazzy-ros-gz-bridge \
    ros-jazzy-ros-gz-sim-demos \
    mesa-utils \
    libgl1 \
    libegl1 \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Auto-source ROS2
RUN echo "source /opt/ros/jazzy/setup.bash" >> /etc/bash.bashrc \
    && echo "source /ros2_ws/install/setup.bash" >> /etc/bash.bashrc \
    && echo "source /usr/share/gazebo/setup.sh" >> /etc/bash.bashrc

# Create workspace
WORKDIR /ros2_ws
RUN mkdir -p src

# Create non-root user
RUN useradd -ms /bin/bash ros
USER ros

CMD ["bash"]
