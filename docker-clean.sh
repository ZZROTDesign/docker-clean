#!/bin/sh
# Maintained by Sean Kilgarriff

#ENVIRONMENT VARIABLES
declare REQUIRED_VERSION="1.9.0"
declare HAS_VERSION=1

#FUNCTIONS
#Prints out Version in numerical order to compare.
function version {
     echo "$@" | awk -F. '{ printf("%03d%03d%03d\n", $1,$2,$3); }';
 }
#Checks if current version of docker works
#Set HAS_VERSION to 0 if they do have a correct version.
 function checkVersion  {
     local Docker_Version="$(docker --version | sed 's/[^0-9.]*\([0-9.]*\).*/\1/')"
     if [ $(version "$Docker_Version") -gt $(version "$REQUIRED_VERSION") ]; then
         HAS_VERSION=0
     else
         echo "Your Version of Docker is below 1.9.0 which is required for full functionality."
         echo "Please upgrade your Docker daemon. Until then, the Volume processing will not work."
     fi
 }

#Make sure that Docker is install/connected.
 function checkDocker {
     #Run Docker ps to make sure that docker is installed
     #As well as that the Daemon is connected.
     docker ps &>/dev/null
     DOCKER_CHECK=$?

     #If Docker Check returns 1 (Error), send a message and exit.
     if [ "$DOCKER_CHECK" -eq 1 ]; then
         echo "Docker is either not installed, or the Docker Daemon is not currently connected."
         echo "Please check your installation and try again."
         exit 1;
     fi
 }

#Stop all running containers to clean them
function stopContainers {
    docker stop $(docker ps -a -q)
}

#Cleans all containers that are stopped.
function cleanContainers {
    docker rm $(docker ps -a -q)
}

#Clears all images
#Credit goes to http://jimhoskins.com/2013/07/27/remove-untagged-docker-images.html
function cleanImages {
    docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
}

#clears all volumes.
function cleanVolumes {
    docker volume rm $(docker volume ls -qf dangling=true)
}



checkDocker
checkVersion
cleanContainers
cleanImages
if [ HAS_VERSION -eq 0 ]; then
    cleanVolumes
else
    exit 0;
fi
