# Docker-Clean

A simple Shell script to clean up the Docker Daemon.

## Requirements

In order to use the volume capabilities, it is required that the Docker Daemon is at least version 1.9+


## Install

curl -s https://raw.githubusercontent.com/ZZROTDesign/docker-clean/master/docker-clean.sh |
sudo tee /usr/local/bin/docker-clean > /dev/null && \
sudo chmod +x /usr/local/bin/docker-clean
    
## Homebrew Install

brew tap zzrotdesign/tap
brew install docker-clean
    
## Usage
    -v or --version to print the current version
    -s or --stop to stop all running containers
    -c or --containers to stop and delete running containers
    -i or --images to stop and delete all containers as well as tagged images
    -a or --all to stop and delete running containers, all images, and restart your docker-machine
    -h or --help help page
    
## License

The code is available under the [MIT License](/LICENSE).
