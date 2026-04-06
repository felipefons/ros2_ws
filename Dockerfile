# syntax=docker/dockerfile:1

FROM ros:jazzy-ros-base

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install basic development tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    build-essential \
    git \
    python3-pip \
    python3-colcon-common-extensions \
    curl \
    ros-jazzy-desktop \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Auto-source ROS2
RUN echo "source /opt/ros/jazzy/setup.bash" >> /etc/bash.bashrc \
    && echo "source /ros2_ws/install/setup.bash" >> /etc/bash.bashrc

# Create workspace
WORKDIR /ros2_ws
RUN mkdir -p src

# Create non-root user
RUN useradd -ms /bin/bash ros
USER ros

CMD ["bash"]
