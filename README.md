[![Build Status](https://travis-ci.org/ZZROTDesign/docker-clean.svg?branch=v1.2.0)](https://travis-ci.org/ZZROTDesign/docker-clean)
[![GitHub release](https://img.shields.io/github/release/zzrotDesign/docker-clean.svg?maxAge=2592000)](https://github.com/ZZROTDesign/docker-clean/releases)
# Docker-Clean

A simple Shell script to clean up the Docker Daemon.

## Requirements

In order to use the volume capabilities, it is required that the Docker Daemon is at least version 1.9+


## Install

    curl -s https://raw.githubusercontent.com/ZZROTDesign/docker-clean/master/docker-clean |
    sudo tee /usr/local/bin/docker-clean > /dev/null && \
    sudo chmod +x /usr/local/bin/docker-clean

## Homebrew Install

    brew tap zzrotdesign/tap
    brew install docker-clean

## Usage

    docker-clean [optional flags below]

  Default without arguments deletes stopped containers, dangling volumes, and untagged images.

    Options:

    -h or --help        Opens this help menu
    -v or --version     Prints the current docker-clean version

    -a or --all         Stops and removes all Containers, Images, and Restarts docker
    -c or --containers  Stops and removes Stopped and Running Containers
    -i or --images      Stops and removes all Containers and Images
    -s or --stop        Stops all running Containers

    -l or --log         Adding this as an additional flag will list all
                        image, volume, and container deleting output




## Contributing to Docker-Clean

### Team members

* [Sean Kilgarriff](https://github.com/Skilgarriff) sean@zzrot.com
* [Killian Brackey](https://github.com/killianbrackey) killian@zzrot.com

Don't hesitate to get in contact with either one of us with problems, questions, etc.


### Adding new features

* Fork it!
* Create your feature branch: git checkout -b my-new-feature
* Commit your changes: git commit -am 'Add some feature'
* Push to the branch: git push origin my-new-feature
* Submit a pull request :D


Don’t get discouraged! We estimate that the response time from the
maintainers is around: 24 hours.
## License

The code is available under the [MIT License](/LICENSE).
