package docker

// Options options to pass to any command
type Options struct {
	DryRun            bool
	ContainersStopped bool
	ContainersAll     bool
	ImagesUntagged    bool
	ImagesAll         bool
	NetworksAll       bool
	Host              string // for -H --host
	Stop              bool   // for -s --stop
	Images            bool   // for -i --images
	Containers        bool   // for -i --containers
	Networks          bool   // for -i --networks
	Restart           bool   // for -r --restart
	Created           bool   // for -c --created
	Tagged            bool   // for -t --tagged
	All               bool   // for -a --all
	Logs              bool   // for -l --logs
}

var (
	//OptionsDockerCleanStop options for docker-clean stop directive
	OptionsDockerCleanStop = Options{
		ContainersStopped: true,
		ContainersAll:     true,
	}
	// OptionsDockerCleanAll options for docker-clean all directive
	OptionsDockerCleanAll = Options{
		ContainersStopped: true,
		ContainersAll:     true,
		ImagesAll:         true,
		ImagesUntagged:    true,
		NetworksAll:       true,
	}
)
