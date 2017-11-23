#!/bin/sh

docker run -ti --rm \
       -e DISPLAY=unix$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v $(pwd)/config:/home/developer/.mozilla \
       firefox