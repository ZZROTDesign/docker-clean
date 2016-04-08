#!/bin/bash
# Maintained by Sean Kilgarriff and Killian Brackey
#
# The MIT License (MIT)
# Copyright © 2016 ZZROT LLC <zzrotdesign@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the “Software”), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

#ENVIRONMENT VARIABLES

#TODO: Add stop containers flag to just stop containers
# @info:	Docker-clean current version
declare VERSION="1.0.0"

# @info:	Required Docker version for Volume functionality
declare REQUIRED_VERSION="1.9.0"

# @info:	Boolean for storing Docker version info
declare HAS_VERSION=false


#FUNCTIONS

# @info:    Parses and validates the CLI arguments
# @args:	Global Arguments $@
parseCli(){

	if [ "$#" -eq 0 ]; then
		dockerClean
	elif [[ $# -eq 1 ]]; then
		case $1 in
			-v | --version) version ;;
			-c | --containers) dockerClean 1 ;;
			-i | --images) dockerClean 2 ;;
			-a | --all) dockerClean 3 ;;
			-h | --help | *) usage ;;
		esac
	else
		usage
	fi
}




# @info:	Prints out Docker-clean current version
function version {
	echo $VERSION
}

# @info:	Prints out usage
function usage {
	echo "Options:"
	echo "-v or --version to print the current version"
	echo "-c or --containers to stop and delete running containers."
	echo "-i or --images to stop and delete all containers as well as tagged images"
	echo "-a or --all to stop and delete running containers, all images, and restart your docker-machine"
	echo "-h or --help for this menu."
}

# @info:	Prints out 3-point version (000.000.000) without decimals for comparison
# @args:	Docker Version of the client
function printVersion {
     echo "$@" | awk -F. '{ printf("%03d%03d%03d\n", $1,$2,$3); }';
 }

# @info:	Checks Docker Version and then configures the HAS_VERSION var.
 function checkVersion  {
     local Docker_Version="$(docker --version | sed 's/[^0-9.]*\([0-9.]*\).*/\1/')"
     if [ $(printVersion "$Docker_Version") -gt $(printVersion "$REQUIRED_VERSION") ]; then
         HAS_VERSION=true
     else
         echo "Your Version of Docker is below 1.9.0 which is required for full functionality."
         echo "Please upgrade your Docker daemon. Until then, the Volume processing will not work."
     fi
 }

# @info:	Checks to see if Docker is installed and connected
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

# @info:	Removes all stopped docker containers.
function cleanContainers {
    stoppedContainers="$(docker ps -qf STATUS=exited )"
    if [ ! "$stoppedContainers" ]; then
        echo No Containers To Clean!
    else
        docker rm $stoppedContainers
    fi
}

# @info:	Removes all containers (including running) with force.
function cleanAllContainers {
	allContainers="$(docker ps -a -q)"
	if [ ! "$allContainers" ]; then
		echo No Containers To Clean!
	else
		docker rm -f $allContainers
	fi
}

# @info:	Removes all untagged docker images.
#Credit goes to http://jimhoskins.com/2013/07/27/remove-untagged-docker-images.html
function cleanImages {
    untaggedImages="$(docker images | grep "^<none>" | awk '{print $3}')"
    if [ ! "$untaggedImages" ]; then
        echo No Untagged Images!
    else
        docker rmi $untaggedImages
    fi
}

# @info:	Deletes all Images including tagged
function cleanAllImages {
	listedImages="$(docker images -q)"
	if [ ! "$listedImages" ]; then
		echo No Images to Delete!
	else
		docker rmi -f $listedImages
	fi
}

# @info:	Removes all Dangling Docker Volumes.
function cleanVolumes {
    danglingVolumes="$(docker volume ls -qf dangling=true)"
    if [ ! "$danglingVolumes" ]; then
        echo No Dangling Volumes!
    else
        docker volume rm $danglingVolumes
    fi
}

# @info:	Restarts and reRuns docker-machine env active machine
function restartMachine {
	active="$(docker-machine active)"
	docker-machine restart $active
	eval $(docker-machine env $active)
	echo Running docker-machine env $active...
	echo "New IP Address for" $active ":" $(docker-machine ip)
}

# @info:	Runs the checks before the main code can be run.
function Check {
	checkDocker
	checkVersion
}

# @info:	Default run option, cleans stopped containers and images
# @args:	1 = Force Clean all Containers, 2 = Force Clean Containers and Images. 3 = Force Clean Containers, Images, and Restart
function dockerClean {

	if [ "$1" == 1 ]; then
		cleanAllContainers
		cleanImages
	elif [ "$1" == 2 ]; then
		cleanAllContainers
		cleanAllImages
	elif [ "$1" == 3 ]; then
		cleanAllContainers
		cleanAllImages
	else
		cleanContainers
		cleanImages
	fi

	#Check if Has Version
	if [ $HAS_VERSION == true ]; then
	    cleanVolumes
	fi

	#This should be after cleaning the Volumes hence the seperation.
	if [ "$1" == 3 ]; then
		restartMachine
	fi

}

#END FUNCTIONS


# @info:	Main function
Check
parseCli "$@"
