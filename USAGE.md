# Usage
This guide walks through proper usage and briefly explains the command(s) behind the usage for those that are familiar with some of the commands Docker provides.  The commands listed run after sanity checks to confirm the command will run properly.

## Default Usage
After the very quick installation docker-clean will be ready to go out of the box.  Assuming the Docker daemon is running, trying

`$ docker-clean`

Commands run:

```
# Containers
docker rm $(docker ps -qf STATUS=exited )
docker rm $(docker ps -qf STATUS=created)
docker rmi -f $(docker images -aq --filter "dangling=true")
docker volume rm $(docker volume ls -qf dangling=true)
```

will complete the default run through.  This simple clean function will only clean out images that do not have a tag, dangling volumes, and stopped containers.  

## Flags

Then come the additional options and flags.  At any point running with a flag `-h`, `--help`, or a flag not specified will bring up the flag reference menu.

#### Stop Containers

`$ docker-clean -s` or `--stop`

Command run:

```
docker stop --time=10 $(docker ps -q)
```

Stops all running containers and will not remove any images or containers.

#### Clean Containers

`$ docker-clean -c` or `--containers`

Commands run:

```
docker rm -f $(docker ps -a -q)
docker rmi -f $(docker images -aq --filter "dangling=true")
docker volume rm $(docker volume ls -qf dangling=true)
```
Stops and removes all containers.

#### Clean Images and Containers

`$ docker-clean -i` or `--images`

Commands run:

```
docker rm -f $(docker ps -a -q)
docker rm -f $(docker images -a -q)
docker volume rm $(docker volume ls -qf dangling=true)
```
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

## Issues
If you find any issues with these commands, it would be great if you opened an issue, or forked and submitted a pull request!
