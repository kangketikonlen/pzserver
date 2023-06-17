#!/bin/bash
docker system prune -f
docker build -t pzserver:0.1 .
docker run -ti --rm pzserver:0.1 /bin/bash