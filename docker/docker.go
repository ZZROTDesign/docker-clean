package docker

import (
	"os"

	"github.com/docker/docker/client"
	"github.com/golang/glog"
)

var dockerCLI *client.Client

func init() {
	cli, err := client.NewEnvClient()
	if err != nil {
		panic(err)
	}
	dockerClientVersion := os.Getenv("DOCKER_API_VERSION")
	glog.Info("Client: ", dockerClientVersion)

	dockerCLI = cli
}
