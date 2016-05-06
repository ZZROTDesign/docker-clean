# Usage for Docker Clean v2.0.0
This guide walks through proper usage and briefly explains the command(s) behind the usage for those that are familiar with some of the commands Docker provides.  The commands listed run after sanity checks to confirm the command will run properly.

    docker-clean [optional flags below]

    Default without arguments deletes stopped containers, dangling volumes, and untagged images.

     "Additional Flag options:"

     -n   or --dry-run    Adding this additional flag will list items to be
                          removed without executing any stopping or removing commands"

     -s   or --stop       Stops all running containers

    -c   or --containers  Removes all stopped containers

    -i   or --images      Removes all untagged images

    -net or --networks    Removes all empty Networks (all network cleans are only empty)

     -r   or --restart     Restarts the docker machine/daemon

     -d   or --created     By default, CREATED containers are set to be removed.  Adding this
                           flag will ensure that all created containers are not cleaned

     -t   or --tagged      Removes all tagged images

     -a   or --all         Stops and removes all Containers, Images, AND Restarts docker

     -l   or --log         Adding this as an additional flag will list all
                           image, volume, and container deleting output


## Dry Run
Before going and trying the default usage, if you have sensitive material you wouldn't like cleared and would like to see
the results of a run, here is how to run all of the commands with a dry run.

Usage for dry-run options:

`docker-clean [flags below, excluding -l and --log] -n` or `--dry-run`

This will print out the result of each command run in a wrapper that doesn't execute the command.  With the newest version (2.0.0+) you can use the `-n` or `--dry-run` as any flag in your execution.


## Default Usage
After the very quick installation docker-clean will be ready to go out of the box.  Assuming the Docker daemon is running, trying

`$ docker-clean`

Commands run:

```
# Containers
docker rmi -f $(docker images -aq --filter "dangling=true")
docker volume rm $(docker volume ls -qf dangling=true)
docker network rm <EMPTY NETWORKS, see below>
```

will complete the default run through.  This simple clean function will only clean out images that do not have a tag, dangling volumes, and empty networks.  The network command is a bit more involved and not listed above.  We run checks to ensure the networks are unused by inspecting the containers themselves.

## Non Flag Options

The following options run a series of commands and are built with particular workflow usages in mind.  Each option can be individually accessed by the flags to handpick usage or supplement these options.  These options are optional the flags can be run independent of these options.

#### Examples

```$ docker-clean stop```

This command will stop and remove all containers (including created), clean dangling volumes, and empty networks.

```$ docker-clean images```

This command will remove all tagged and untagged images not being used by running containers.  It will also remove dangling volumes and empty networks.

```$ docker-clean run```

For those of you that are familiar with versions of docker-clean before v2.0.0, this has the same functionality as the old default run.  This removes all stopped containers, untagged images, dangling volumes, and empty networks.

``$ docker-clean all``

This is similar to the ```-a```, ```-all``` flag option except it will not restart docker as the flags will.  It stops and removes all containers, tagged and untagged images, dangling volumes, and networks.

At the bottom of this document is an example of the output of a dry run using this option.


## Flags

Then come the additional options and flags.  At any point running with a flag `-h`, `--help`, or a flag not specified will bring up the flag reference menu.  The help menu is available at the top of this document as well for reference.

#### Stop Containers

`$ docker-clean -s` or `--stop`

Command run:

```
docker stop $(docker ps -q)
```

Stops all running containers and will not remove any images or containers, volumes, or networks.


#### Clean Containers

`$ docker-clean -c` or `--containers`

Commands run:

```
docker rmi -f $(docker images -aq --filter "STATUS=exited")
```
This flag only removes stopped containers.

#### Clean Images and Containers

`$ docker-clean -i` or `--images`

Removes all containers and images.

#### Clean All and Restart Daemon

`$ docker-clean -a` or `--all`

Commands run:

```
docker rm -f $(docker ps -a -q)
docker rm -f $(docker images -a -q)
docker volume rm $(docker volume ls -qf dangling=true)
```
Restart (Mac, Windows)

`docker-machine restart`

Restart (Linux)

`sudo service docker restart`


Stops and removes all containers, images, and dangling volumes and restarts the docker daemon (supports OSX, Windows, and Linux).

### Additional Flags

For debugging purposes and so you can see the more traditional output from these commands there are a couple of additional flags.

#### Version
`docker-clean -v` or `--version`

Prints the docker clean version

#### Log (Verbose)
Adding `-l` or `--log` as an additional flag will print out the full output from the docker commands on each of the other options as opposed to the suppressed output with counts.  This typically is the ID of the images, containers, and volumes being removed.  The id's have been left in for the `-s`, `--stop` function.

Examples:
```
$ docker-clean -l` or `--log`
$ docker-clean --containers --log
$ docker-clean -s -l
```

## Dry Run Example

Below is a dry run example output.
Containers:
```
    $ docker ps -a
    CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS              PORTS                     NAMES
    8da973093341        training/webapp      "python app.py"          3 seconds ago       Up 3 seconds        0.0.0.0:32769->5000/tcp   web
    3424ffbb418d        zzrot/alpine-caddy   "tini caddy --conf /e"   3 seconds ago       Up 3 seconds                                  extra
```

Images:
```
$ docker images -a
REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
zzrot/alpine-caddy    latest              5dac1ba1d438        2 days ago          48.16 MB
zzrot/alpine-node     latest              ab87df339f32        3 weeks ago         25.48 MB
zzrot/whale-awkward   latest              08e0a241de0d        4 weeks ago         516 B
training/webapp       latest              6fae60ef3446        11 months ago       348.8 MB
```

```
$ docker-clean all --dry-run
Dry run on stoppage of running containers:
Running without -n or --dry-run flag will stop the listed containers:

Container ID: 8da973093341 IMAGE: "python"/["app.py"] NAME: "/web"
Container ID: 3424ffbb418d IMAGE: "tini"/["caddy","--conf","/etc/Caddyfile"] NAME: "/extra"

Dry run on removal of stopped containers:
Running without -n or --dry-run flag will remove the listed containers:

Container ID: 8da973093341 IMAGE: "python"/["app.py"] NAME: "/web"
Container ID: 3424ffbb418d IMAGE: "tini"/["caddy","--conf","/etc/Caddyfile"] NAME: "/extra"

Dry run on removal of images:
Running without -n or --dry-run flag will remove the listed images:

REPOSITORY/TAG: ["zzrot/alpine-caddy:latest"] IMAGE ID: 5dac1ba1d438
REPOSITORY/TAG: ["zzrot/alpine-node:latest"] IMAGE ID: ab87df339f32
REPOSITORY/TAG: ["zzrot/whale-awkward:latest"] IMAGE ID: 08e0a241de0d
REPOSITORY/TAG: ["training/webapp:latest"] IMAGE ID: 6fae60ef3446
You've cleared approximately MB: 422 of space!

Dry run on removal of dangling volumes:
Running without -n or --dry-run flag will stop the listed dangling volumes:
DRIVER: "local" NAME: 45bc5fb98fc95e67512e75fcc56fd52b0f443c17010850517f97a30340e45249

DRIVER: "local" NAME: 75e24a294862504426e2e4c4aa83bf69c5f8a5ebc9586518e7f1dd26b7202333

Dangling volumes that would be removed from containers to be deleted...
VOLUME: [{"Name":"a7a4020d3739b4306e16a6ddd776b852ed08b4d0cdf4387e048ea123b756941f","Source":"/mnt/sda1/var/lib/docker/volumes/a7a4020d3739b4306e16a6ddd776b852ed08b4d0cdf4387e048ea123b756941f/_data","Destination":"/webapp","Driver":"local","Mode":"","RW":true,"Propagation":""}]

VOLUME: [{"Name":"71c6e02b11056d2b379063314b0826773167d8cb11058752821aa6375737805b","Source":"/mnt/sda1/var/lib/docker/volumes/71c6e02b11056d2b379063314b0826773167d8cb11058752821aa6375737805b/_data","Destination":"/webapp","Driver":"local","Mode":"","RW":true,"Propagation":""}]


Dry run on removal of networks:
No empty networks. Running without -n or --dry-run flag won't remove any networks.

```
## Issues
If you find any issues with these commands, it would be great if you opened an issue, or forked and submitted a pull request!
