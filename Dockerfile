# syntax=docker/dockerfile:1

FROM ros:jazzy-ros-base

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    build-essential \
    git \
    python3-pip \
    python3-colcon-common-extensions \
    curl \
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

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Workspace
WORKDIR /ros2_ws
RUN mkdir -p src

# User
ARG USERNAME=ros
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID $USERNAME || true && \
    useradd -m -u $UID -g $GID -s /bin/bash $USERNAME && \
    chown -R $USERNAME:$USERNAME /ros2_ws

USER $USERNAME
ENV USER=$USERNAME
ENV HOME=/home/$USERNAME

# Auto-source
RUN echo "source /opt/ros/jazzy/setup.bash" >> /etc/bash.bashrc && \
    echo "[ -f /ros2_ws/install/setup.bash ] && source /ros2_ws/install/setup.bash" >> /etc/bash.bashrc

CMD ["bash"]