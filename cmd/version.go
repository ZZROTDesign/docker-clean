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
)

type VersionCmd struct {
	cobraCommand *cobra.Command
}

// versionCmd represents the version command
var versionCmd = VersionCmd{
	cobraCommand: &cobra.Command{
		Use:   "version",
		Short: "Shows docker-clean version",
		Run: func(cmd *cobra.Command, args []string) {
			// TODO: Work your own magic here
			fmt.Println("version called")
		},
	},
}

func init() {
	cmd := versionCmd.cobraCommand
	RootCmd.AddCommand(cmd)
	cmd.Run = func(cmd *cobra.Command, args []string) {
		err := versionCmd.Run()
		if err != nil {
			fmt.Println(err.Error())
			os.Exit(100)
		}

	}
	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// versionCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// versionCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")

}

// Run runs docker-clean version command
func (c *VersionCmd) Run() error {
	s := "Version " + DockerCleanVersion
	fmt.Println(s)

	return nil
}
