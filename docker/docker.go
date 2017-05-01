package docker

import "github.com/docker/docker/client"

var dockerCLI *client.Client

func init() {
	cli, err := client.NewEnvClient()
	if err != nil {
		panic(err)
	}

	dockerCLI = cli
}
