[![Build Status](https://travis-ci.org/ZZROTDesign/docker-clean.svg?branch=v2.0.4)](https://travis-ci.org/ZZROTDesign/docker-clean)[![GitHub release](https://img.shields.io/github/release/zzrotDesign/docker-clean.svg)](https://github.com/ZZROTDesign/docker-clean/releases)
# Docker-Clean

[![Join the chat at https://gitter.im/ZZROTDesign/docker-clean](https://badges.gitter.im/ZZROTDesign/docker-clean.svg)](https://gitter.im/ZZROTDesign/docker-clean?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

A simple Shell script to clean up the Docker Daemon.

## Requirements

In order to use the volume capabilities, it is required that the Docker Daemon is at least version 1.9+


## Install

    curl -s https://raw.githubusercontent.com/ZZROTDesign/docker-clean/v2.0.4/docker-clean |
    sudo tee /usr/local/bin/docker-clean > /dev/null && \
    sudo chmod +x /usr/local/bin/docker-clean

## Homebrew Install
    brew update
    brew install docker-clean

**UPDATE:** Docker-clean v2.0.3+ will be available without using our tap.  However we will keep both maintained.

#### Upgrade (for new versions)

    brew update && brew upgrade docker-clean

For curl installs, re-running the script above will install the newest version.

## Running from a docker container

``` shell
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock zzrot/docker-clean [optional flags below]
```

*Docker Image tags can be found on [Docker Hub](https://hub.docker.com/r/zzrot/docker-clean/tags/)*
for different docker-clean versions 2.0.4+ with various image sizes.  


## Usage

For a more in depth look at the usage and commands run without browsing the script itself check out our [USAGE.md](https://github.com/ZZROTDesign/docker-clean/blob/master/USAGE.md).

    docker-clean [optional flags below]

  Default without arguments deletes stopped containers, dangling volumes, and untagged images.

      stop         Stops and removes all containers, cleans dangling volumes, and networks

      images       Removes all tagged and untagged images, stopped containers, dangling volumes, and networks

      run          Removes all stopped containers, untagged images, dangling volumes, and networks

      all          Stops and removes all containers, images, volumes and networks


     "Additional Flag options:"

     -n   or --dry-run    Adding this additional flag will list items to be
                          removed without executing any stopping or removing commands"

     -s   or --stop       Stops all running containers

    -c   or --containers  Removes all stopped containers

    -i   or --images      Removes all untagged images

    -net or --networks    Removes all empty Networks (all network cleans are only empty)

    -H   or --host        Specifies the docker host to run against
	                      Useful for docker swarm maintenance ie: -H 127.0.0.1:4000"

     -r   or --restart     Restarts the docker machine/daemon

     -d   or --created     By default, CREATED containers are set to be removed.  Adding this
                           flag will ensure that all created containers are not cleaned

     -t   or --tagged      Removes all tagged images

     -a   or --all         Stops and removes all Containers, Images, AND Restarts docker

     -l   or --log         Adding this as an additional flag will list all
                           image, volume, and container deleting output



## Contributing to Docker-Clean

### Team members

* [Sean Kilgarriff](https://github.com/Skilgarriff) sean@zzrot.com T: [@seankilgarriff](https://twitter.com/SeanKilgarriff)
* [Killian Brackey](https://github.com/killianbrackey) killian@zzrot.com T: [@kmbrackey](https://twitter.com/kmbrackey)

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

### ShellCheck

We use ShellCheck to keep our code consistent and readable. Any feature pushed that does not pass a ShellCheck will fail on Travis build, and thus we cannot accept the pull request. Please lint your code before submitting it! :).

(Keep in mind that bats does not have to be ShellChecked, and thus if you are adding tests to .bats don't worry about linting.)

You can either download the ShellCheck program: https://github.com/koalaman/shellcheck or use the ShellCheck website: http://www.shellcheck.net/

## License

The code is available under the [MIT License](/LICENSE).
