package docker

import "fmt"

// Stats base stat object to keep track of statistics
type Stats struct {
	ContainersRemoved int
	ContainersStopped int
	ImagesRemoved     int
	NetworksRemoved   int
	SpaceSavedInMB    int
	Options           Options // options used on this run of docker clean
	Error             error
}

func (s *Stats) returnErrorStats(err error) *Stats {
	s.Error = err
	return s
}

func (s *Stats) String() string {
	dryRunString := ""
	if s.Options.DryRun {
		dryRunString = "\nDRY RUN: All stats are projection of real run"
	}

	return fmt.Sprintf(`%s
Containers Stopped: %d
Containers Removed: %d
Images Removed: %d
Space Saved In MB: %d
`, dryRunString,
		s.ContainersStopped,
		s.ContainersRemoved,
		s.ImagesRemoved,
		s.SpaceSavedInMB,
	)

}
