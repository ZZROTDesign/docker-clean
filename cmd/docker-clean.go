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
	"github.com/spf13/viper"
	"github.com/zzrotdesign/docker-clean/docker"
)

// DockerCleanVersion is the root docker clean version number
const DockerCleanVersion = "0.1.0"

var (
	cfgFile string
	options *docker.Options
)

// RootCmd represents the base command when called without any subcommands
var RootCmd = &cobra.Command{
	Use:   "docker-clean",
	Short: "A script that cleans docker containers, images, volumes, and networks.",
	// Uncomment the following line if your bare application
	// has an action associated with it:
	//	Run: func(cmd *cobra.Command, args []string) { },
}

// Execute adds all child commands to the root command sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	if err := RootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(-1)
	}
}

func init() {
	cobra.OnInitialize(initConfig)
	options = &docker.Options{}
	// Here you will define your flags and configuration settings.
	// Cobra supports Persistent Flags, which, if defined here,
	// will be global for your application.

	RootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.docker-clean.yaml)")
	RootCmd.PersistentFlags().BoolVarP(&options.DryRun, "dry-run", "n", false, "Run as dry run")
	RootCmd.PersistentFlags().StringVar(&options.Host, "host", "H", "Set different host for swarm configurations")
	RootCmd.PersistentFlags().BoolVarP(&options.Stop, "stop", "s", false, "Clean stopped containers only")
	RootCmd.PersistentFlags().BoolVarP(&options.Images, "images", "i", false, "Clean all tagged images")
	RootCmd.PersistentFlags().BoolVarP(&options.Containers, "containers", "c", false, "Clean all stopped containers")
	RootCmd.PersistentFlags().BoolVarP(&options.Networks, "networks", "n", false, "Cleans all networks")
	RootCmd.PersistentFlags().BoolVarP(&options.Restart, "restart", "r", false, "Restarts deamon")
	RootCmd.PersistentFlags().BoolVarP(&options.Created, "created", "d", false, "Remove created containers/images")
	RootCmd.PersistentFlags().BoolVarP(&options.Restart, "tagged", "t", false, "Cleans tagged images and untagged images")
	RootCmd.PersistentFlags().BoolVarP(&options.All, "all", "a", false, "Cleans everything and restarts daemon")
	RootCmd.PersistentFlags().BoolVarP(&options.Logs, "restart", "r", false, "Logs all images, containers, and networks removed")

	// Cobra also supports local flags, which will only run
	// when this action is called directly.
	RootCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}

// initConfig reads in config file and ENV variables if set.
func initConfig() {
	if cfgFile != "" { // enable ability to specify config file via flag
		viper.SetConfigFile(cfgFile)
	}

	viper.SetConfigName(".docker-clean")   // name of config file (without extension)
	viper.AddConfigPath(os.Getenv("HOME")) // adding home directory as first search path
	viper.AutomaticEnv()                   // read in environment variables that match

	// If a config file is found, read it in.
	if err := viper.ReadInConfig(); err == nil {
		fmt.Println("Using config file:", viper.ConfigFileUsed())
	}
}
