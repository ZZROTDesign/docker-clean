package docker

import "fmt"

// Stats base stat object to keep track of statistics
type Stats struct {
	ContainersRemoved int
	ContainersStopped int
	ImagesRemoved     int
	NetworksRemoved   int
	SpaceSavedInMB    int
	Error             error
}

func (s *Stats) returnErrorStats(err error) *Stats {
	s.Error = err
	return s
}

func (s *Stats) String() string {
	return fmt.Sprintf(`
Containers Stopped: %d
Containers Removed: %d
Images Removed: %d
Space Saved In MB: %d
`, s.ContainersStopped,
		s.ContainersRemoved,
		s.ImagesRemoved,
		s.SpaceSavedInMB,
	)
}
