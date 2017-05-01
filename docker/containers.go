package docker

import (
	"context"
	"time"

	"github.com/docker/docker/api/types"
	"github.com/golang/glog"
)

const (
	// ContainerStateRunning state for container that is currently running
	ContainerStateRunning = "running"
	// ContainerStateExited state for container that is stopped or has exited
	ContainerStateExited = "exited"
)

var (
	// defaultContainerStopTimeout is the default time before a stop is timed out
	defaultContainerStopTimeout *time.Duration
)

func init() {
	timeout := time.Duration(time.Second * 15)
	defaultContainerStopTimeout = &timeout
}

// GetAllContainers returns array of all containers
func GetAllContainers() ([]types.Container, error) {

	containers, err := dockerCLI.ContainerList(context.Background(), types.ContainerListOptions{
		All: true,
	})
	if err != nil {
		panic(err)
	}

	return containers, nil
}

// StopAndRemoveAllContainers stops and removes all containers
func StopAndRemoveAllContainers() *Stats {
	stats := &Stats{}

	containers, err := GetAllContainers()
	if err != nil {
		glog.Error(err)
		return stats.returnErrorStats(err)
	}

	// run in background context
	context := context.Background()

	for _, container := range containers {
		if container.State == ContainerStateRunning {
			err = dockerCLI.ContainerStop(context, container.ID, defaultContainerStopTimeout)
			if err != nil {
				glog.Error(err)
				return stats.returnErrorStats(err)
			}

			stats.ContainersStopped++
		}

		// remove with force, volumes, and links
		// TODO : make optional -- this is the nuclear option
		err = dockerCLI.ContainerRemove(context, container.ID, types.ContainerRemoveOptions{
			Force:         true,
			RemoveVolumes: true,
		})
		if err != nil {
			glog.Error(err)
			return stats.returnErrorStats(err)
		}

		stats.ContainersRemoved++

	}

	return stats
}
