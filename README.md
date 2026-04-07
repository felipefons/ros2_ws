# ROS2 Jazzy + Turtlesim (Docker)

Run ROS2 Jazzy with turtlesim in one command.

----------------------------------------------------------

## Quick Start

```bash
git clone https://github.com/felipefons/ros2_ws.git
cd ros2_ws
chmod +x run.sh
./run.sh
```


----------------------------------------------------------

##  What happens

* Downloads the Docker image (if needed)
* Starts the container


----------------------------------------------------------

## Run turtlesim and teleop_key

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

##  Requirements

* Docker installed
* Linux with GUI


----------------------------------------------------------

##  If it doesn’t work

Run this once:

```bash
xhost +local:docker
```
