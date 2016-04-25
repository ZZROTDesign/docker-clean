# Usage
This guide walks through proper usage and briefly explains the command behind the usage for those that are familiar with some of the commands Docker provides.  The commands listed run after sanity checks to confirm the command will run properly.

After the very quick installation docker-clean will be ready to go out of the box.  Assuming the Docker daemon is running, trying

`$ docker-clean`

Commands run:

```
docker rm $(docker ps -qf STATUS=exited )
docker rm $(docker ps -qf STATUS=created)

docker rmi -f $(docker images -aq --filter "dangling=true")

```

will complete the default run through.  This simple clean function will only clean out images that do not have a tag, dangling volumes, and stopped containers.  


Then come the additional options and flags.  At any point running with a flag `-h`, `--help`, or a flag not specified will bring up the flag reference menu.

`$ docker-clean -s` or `--stop`

Command run:

```
docker stop --time=10 $(docker ps -q)
```

will stop all running containers and will not remove any images or containers.

`$ docker-clean -i` or `--images` will remove all containers and images.

`$ docker-clean -c` or `--containers` will stop and remove all containers.

`$ docker-clean -a` or `--all` will stop and remove all containers, images, and dangling volumes and restarts the docker daemon (supports OSX, Windows, and Linux).
