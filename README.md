[![Build Status](https://travis-ci.org/ZZROTDesign/docker-clean.svg?branch=v1.4.1)](https://travis-ci.org/ZZROTDesign/docker-clean)[![GitHub release](https://img.shields.io/github/release/zzrotDesign/docker-clean.svg)](https://github.com/ZZROTDesign/docker-clean/releases)
# Docker-Clean

[![Join the chat at https://gitter.im/ZZROTDesign/docker-clean](https://badges.gitter.im/ZZROTDesign/docker-clean.svg)](https://gitter.im/ZZROTDesign/docker-clean?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

A simple Shell script to clean up the Docker Daemon.

## Requirements

In order to use the volume capabilities, it is required that the Docker Daemon is at least version 1.9+


## Install

    curl -s https://raw.githubusercontent.com/ZZROTDesign/docker-clean/v1.4.1/docker-clean |
    sudo tee /usr/local/bin/docker-clean > /dev/null && \
    sudo chmod +x /usr/local/bin/docker-clean

## Homebrew Install

    brew tap zzrotdesign/tap
    brew install docker-clean
    
#### Upgrade (for new versions)

    brew update && brew upgrade docker-clean
   
For curl installs, re-running the script above will install the newest version.
    
    
## Usage

For a more in depth look at the usage and commands run without browsing the script itself check out our [USAGE.md](https://github.com/ZZROTDesign/docker-clean/blob/master/USAGE.md).

    docker-clean [optional flags below]

  Default without arguments deletes stopped containers, dangling volumes, and untagged images.

    Options:

    -h or --help        Opens this help menu
    -v or --version     Prints the current docker-clean version

    -a or --all         Stops and removes all Containers, Images, and Restarts docker
    -c or --containers  Stops and removes Stopped and Running Containers
    -net or --networks  Removes all empty Networks

    -i or --images      Stops and removes all Containers and Images
    -s or --stop        Stops all running Containers

    -l or --log         Adding this as an additional flag will list all
                        image, volume, and container deleting output

    -n or --dry-run     Dry run, added at the end to run each command and see
                        the results without removing or stopping anything.


## Contributing to Docker-Clean

### Team members

* [Sean Kilgarriff](https://github.com/Skilgarriff) sean@zzrot.com
* [Killian Brackey](https://github.com/killianbrackey) killian@zzrot.com

Don't hesitate to get in contact with either one of us with problems, questions, etc.

Check out our [blog post](https://blog.zzrot.com/docker-clean-utility/) on why we put this script together.


### Adding new features

* Fork it!
* Create your feature branch: git checkout -b my-new-feature
* Commit your changes: git commit -am 'Add some feature'
* Push to the branch: git push origin my-new-feature
* Submit a pull request :D

For any new features you hope to see, you can also edit the REQUESTS.md file.
https://github.com/ZZROTDesign/docker-clean/blob/master/REQUESTS.md

Don’t get discouraged! We estimate that the response time from the
maintainers is around: 24 hours.
## License

The code is available under the [MIT License](/LICENSE).
