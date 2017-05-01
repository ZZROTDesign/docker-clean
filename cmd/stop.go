// Copyright © 2017 NAME HERE <EMAIL ADDRESS>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
	"github.com/zzrotdesign/docker-clean/docker"
)

// stopCmd represents the stop command
var stopCmd = &cobra.Command{
	Use:   "stop",
	Short: "Stops all running containers",
	Long:  `Stops all running containers`,
	Run: func(cmd *cobra.Command, args []string) {
		// TODO: Work your own magic here
		fmt.Println("stop called")
	},
}

var Verbose bool
var DryRun bool

func init() {
	RootCmd.AddCommand(stopCmd)

	// Here you will define your flags and configuration settings.
	stopCmd.PersistentFlags().BoolVarP(&DryRun, "dry-run", "n", false, "Run as dry run")

	var stats *docker.Stats
	if stopCmd.Flag("dry-run") != nil {
		fmt.Println("Docker clean dry run...")
		stats = docker.StopAndRemoveAllContainers(docker.Options{DryRun: true})
	} else {
		stats = docker.StopAndRemoveAllContainers()
	}
	if stats.Error != nil {
		fmt.Println(stats.Error.Error())
		os.Exit(100)
	}

	fmt.Println(stats.String())

}
