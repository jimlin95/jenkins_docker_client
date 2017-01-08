#!/bin/bash 
#create image
if [ "$1" == "clear" ];then
	sudo docker build --no-cache=true -t jimlin95/jenkins_docker_client .
else
	sudo docker build -t jimlin95/jenkins_docker_client .
fi
