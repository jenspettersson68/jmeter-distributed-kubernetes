#!/bin/bash
# Build images
# Run script ./create_images.sh 
# For Ubuntu build, please change to Ubuntu Docerfile

docker build -t jmeter-base:latest -f Dockerfile-base-centos .
docker build -t jmeter-master:latest -f Dockerfile-master .
docker build -t jmeter-slave:latest -f Dockerfile-slave .


