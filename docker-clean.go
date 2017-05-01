package main

import (
	"context"
	"fmt"
	"os"

	"github.com/davecgh/go-spew/spew"
	"github.com/docker/docker/api/types"
	"github.com/docker/docker/client"
	"github.com/golang/glog"
)

func main() {
	dockerClientVersion := os.Getenv("DOCKER_API_VERSION")
	glog.Info("Client: ", dockerClientVersion)

	cli, err := client.NewEnvClient()
	if err != nil {
		panic(err)
	}

	containers, err := cli.ContainerList(context.Background(), types.ContainerListOptions{})
	if err != nil {
		panic(err)
	}

	stats, err := cli.ContainerStats(context.Background(), containers[0].ID, false)
	if err != nil {
		glog.Info(err)
	}

	glog.Info(spew.Sdump(stats))

	for _, container := range containers {
		fmt.Printf("%s %s\n", container.ID[:10], container.Image)
	}
}
