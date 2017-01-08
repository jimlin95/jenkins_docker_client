#!/bin/bash
#run docker
docker run --name jenkins_docker_client -v /tmp/.X11-unix:/tmp/.X11-unix -v $PWD:/src -d -p 2222:22 jimlin95/jenkins_docker_client
