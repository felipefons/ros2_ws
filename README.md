# ROS2 Jazzy + Gazebo (Docker)

Run ROS2 Jazzy with Gazebo in one command.

----------------------------------------------------------

## Quick Start

```bash
git clone https://github.com/felipefons/ros2_ws.git
cd ros2_ws
chmod +x run_gz.sh
./run_gz.sh
```

Obs.: to run without Gazebo: run.sh

----------------------------------------------------------



##  What happens

* Downloads the Docker image (if needed)
* Starts the container


----------------------------------------------------------

## OPTIONAL: Run turtlesim and teleop_key

```bash
ros2 run turtlesim turtlesim_node
docker ps
docker exec -it <container_id> bash
```


```bash (2)
ros2 run turtlesim turtle_teleop_key
```


----------------------------------------------------------


##  What happens

* Runs turtlesim_node
* Opens a new shell inside the same container
* Runs turtlesim_teleop_key (to control the turtle)


----------------------------------------------------------

## OPTIONAL: Run Gazebo demo

```bash
gz sim shapes.sdf
```


----------------------------------------------------------


##  What happens

* Runs a Gazebo demo with simple 3D shapes in an empty world


----------------------------------------------------------

##  Requirements

* Docker installed
* Linux with GUI


----------------------------------------------------------

##  If it doesn’t work

Run this once:

```bash
xhost +local:docker
```
