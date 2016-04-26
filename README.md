[![Build Status](https://travis-ci.org/ZZROTDesign/docker-clean.svg?branch=dry-run)](https://travis-ci.org/ZZROTDesign/docker-clean)[![GitHub release](https://img.shields.io/github/release/zzrotDesign/docker-clean.svg)](https://github.com/ZZROTDesign/docker-clean/releases)
# Docker-Clean

A simple Shell script to clean up the Docker Daemon.

## Requirements

In order to use the volume capabilities, it is required that the Docker Daemon is at least version 1.9+


## Install (will install pre-release with dry run)

    curl -s https://raw.githubusercontent.com/ZZROTDesign/docker-clean/v1.3.1/docker-clean |
    sudo tee /usr/local/bin/docker-clean > /dev/null && \
    sudo chmod +x /usr/local/bin/docker-clean

## Homebrew Install (will install v1.3.1 without dry run)

    brew tap zzrotdesign/tap
    brew install docker-clean

## Usage

For a more in depth look at the usage and commands run without browsing the script itself check out our [USAGE.md](https://github.com/ZZROTDesign/docker-clean/blob/master/USAGE.md).

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

    -n or --dry-run     Dry run, added at the end to run each command and see
                        the results without removing or stopping anything.
For a full walk through of dry-run for this branch check out the [USAGE.md](https://github.com/ZZROTDesign/docker-clean/blob/dry-run/USAGE.md)




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


Don’t get discouraged! We estimate that the response time from the
maintainers is around: 24 hours.
## License

The code is available under the [MIT License](/LICENSE).
