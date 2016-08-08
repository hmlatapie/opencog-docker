#! /bin/bash
#
# Run the docker container. Stop any previously running copies.
#
./stop.sh

# Enable local, non-network connections to X-Server
xhost +local:root

# Assorted grunge to let X11 use the 3D graphics acceleration.
# 11311 is the roscore port -- but we have no need to expose it...
# 4444 is the relex parse server -- again, no need to expose it just now.
# -p 11311:11311 -p 4444:4444
nvidia-docker run -it --name="eva-opencog" \
   -e DISPLAY=:0.0 --privileged \
   -v /dev/video0:/dev/video0 -v /dev/snd:/dev/snd  \
   -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 -v /dev/dri:/dev/dri \
   -v /dev/shm:/dev/shm opencog/eva-opencog /bin/bash 

xhost -local:root
clear
