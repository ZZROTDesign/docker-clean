# Usage
This guide walks through proper usage and briefly explains the command behind the usage for those that are familiar with some of the commands Docker provides.  The commands listed run after sanity checks to confirm the command will run properly.

The command to clean dangling volumes runs only if the docker version is compatible with the command.

After the very quick installation docker-clean will be ready to go out of the box.  Assuming the Docker daemon is running, trying

`$ docker-clean`

Commands run:

```
docker rm $(docker ps -qf STATUS=exited )
docker rm $(docker ps -qf STATUS=created)

docker rmi -f $(docker images -aq --filter "dangling=true")

docker volume rm $(docker volume ls -qf dangling=true)

```

will complete the default run through.  This simple clean function will only clean out images that do not have a tag, dangling volumes, and stopped containers.  


Then come the additional options and flags.  At any point running with a flag `-h`, `--help`, or a flag not specified will bring up the flag reference menu.

`$ docker-clean -s` or `--stop`

Command run:

```
docker stop --time=10 $(docker ps -q)
```

Stops all running containers and will not remove any images or containers.

`$ docker-clean -i` or `--images`

Commands run:

```
docker rm -f $(docker ps -a -q)
docker rm -f $(docker images -a -q)
docker volume rm $(docker volume ls -qf dangling=true)
```
Removes all containers and images.

`$ docker-clean -c` or `--containers`

Commands run:

```
docker rm -f $(docker ps -a -q)
docker rmi -f $(docker images -aq --filter "dangling=true")
docker volume rm $(docker volume ls -qf dangling=true)
```
Stops and removes all containers.

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
