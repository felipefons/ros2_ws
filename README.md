# ROS2 Jazzy + Gazebo (Docker)

Dockerized ROS2 Jazzy workspace with Gazebo support for simulation and development.

---

# Quick Start

```bash
git clone https://github.com/felipefons/ros2_ws.git
cd ros2_ws
chmod +x run_gz.sh
./run_gz.sh
```

This will:
- Pull the Docker image (if not available)
- Start a ROS2 Jazzy container
- Enable GUI support (Gazebo / RViz)

---

# System Overview

Inside the container:

- ROS2 Jazzy
- Gazebo simulation tools
- Colcon workspace at `/ros2_ws`

---

# ROS2 Example (Turtlesim)

Inside the container:

```bash
ros2 run turtlesim turtlesim_node
```

Open a second terminal:

```bash
docker ps
docker exec -it <container_id> bash
```

Run teleoperation:

```bash
ros2 run turtlesim turtle_teleop_key
```

---

# Gazebo Example

Run a simple simulation:

```bash
gz sim shapes.sdf
```

---

# Build Workspace

Inside the container:

```bash
colcon build
source install/setup.bash
```

Run example nodes:

```bash
ros2 run my_py_pkg talker
ros2 run my_py_pkg listener
```

---

# GUI Setup (Host Machine)

Enable Docker GUI access (run once per session):

```bash
xhost +local:docker
```

---

# Project Structure

```
ros2_ws/
├── src/              # ROS2 packages
├── run_gz.sh         # Docker launcher script
├── Docker image      # ROS2 Jazzy + Gazebo environment
```

---