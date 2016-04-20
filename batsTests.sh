#!/usr/bin/env bats

# PRODUCTION Bats Tests for Travis CI

# Initial pass at testing for docker-clean
# These tests simply test each of the options currently available

# To run the tests locally run brew install bats or
# sudo apt-get install bats and then bats batsTest.bats

# WARNING: Runing these tests will clear all of your images/Containers

@test "Check that docker client is available" {
  command -v docker
}

@test "Run docker ps (check daemon connectivity)" {
  run docker ps
  [ $status = 0 ]
}

@test "Docker Clean Version echoes" {
  run ./docker-clean -v
  [ $status = 0 ]
}

@test "Testing build function for most other function tests" {
  build
  [ $status = 0 ]
  clean
}

@test "Help menu opens" {
  # On -h flag
  run ./docker-clean -h
  [[ ${lines[0]} =~ "Options:" ]]
  run ./docker-clean --help
  [[ ${lines[0]} =~ "Options:" ]]

  # On unspecified tag
  run ./docker-clean -z
  [[ ${lines[0]} =~ "Options:" ]]
  #clean
}

@test "Test container stopping (-s --stop)" {
  build
  [ $status = 0 ]
  runningContainers="$(docker ps -q)"
  [ $runningContainers ]
  run ./docker-clean -s
  runningContainers="$(docker ps -q)"
  [ ! $runningContainers ]

  clean
}

@test "Clean Containers test" {
  stoppedContainers="$(docker ps -a)"
  untaggedImages="$(docker images -aq --filter "dangling=true")"
  run docker kill $(docker ps -a -q)
  [ "$stoppedContainers" ]

  run ./docker-clean
  stoppedContainers="$(docker ps -qf STATUS=exited )"
  createdContainers="$(docker ps -qf STATUS=created)"
  [ ! "$stoppedContainers" ]
  [ ! "$createdContainers" ]

  clean
}

@test "Clean All Containers Test" {
  build
  [ $status = 0 ]
  allContainers="$(docker ps -a -q)"
  [ "$allContainers" ]
  run ./docker-clean -c
  allContainers="$(docker ps -a -q)"
  [ ! "$allContainers" ]

  clean
}

@test "Clean images (not all)" {
  skip
  build
  [ $status = 0 ]
  untaggedImages="$(docker images -aq --filter "dangling=true")"
  [ "$untaggedImages" ]

  run ./docker-clean
  untaggedImages="$(docker images -aq --filter "dangling=true")"
  [ ! "$untaggedImages" ]

  clean
}

@test "Clean all images function" {
  build
  [ $status = 0 ]
  listedImages="$(docker images -aq)"
  [ "$listedImages" ]

  run ./docker-clean --images
  listedImages="$(docker images -aq)"
  [ ! "$listedImages" ]

  clean
}

@test "Clean Volumes function" {
  skip "Work in progress"
  build
  [ $status = 0 ]

  clean
}


# TODO figure out the -qf STATUS exited
# TODO Write test with an untagged image
@test "Default run through -- docker-clean (without arguments)" {
  build
  [ $status = 0 ]
  stoppedContainers="$(docker ps -a)"
  untaggedImages="$(docker images -aq --filter "dangling=true")"
  run docker kill $(docker ps -a -q)
  [ "$stoppedContainers" ]
  #[ "$untaggedImages" ]
  run ./docker-clean

  stoppedContainers="$(docker ps -qf STATUS=exited )"
  createdContainers="$(docker ps -qf STATUS=created)"
  [ ! "$stoppedContainers" ]
  [ ! "$createdContainers" ]
  [ ! "$untaggedImages" ]

  clean
}

# Test for counting correctly
@test "Testing counting function" {
  build
  [ $status = 0 ]
  run docker kill $(docker ps -a -q)
  run ./docker-clean
  [[ ${lines[0]} =~ "Cleaning containers..." ]]
  [[ ${lines[1]} =~ "Stopped containers cleaned: 1" ]]
  run ./docker-clean -i
  [[ ${lines[1]} =~ "Cleaning Images..."  ]]
  [[ ${lines[2]} =~ "Images cleaned: 4" ]]

  clean
}

# Testing for successful restart
# TODO Write a more intensive restart test
 @test "Restart function" {
  skip
  build
  [ $status = 0 ]
  run ../docker-clean -a
  [ $status = 0 ]
  clean
}

# Helper FUNCTIONS

function build() {
    if [ $(docker ps -a -q) ]; then
      docker rm -f $(docker ps -a -q)
    fi
    run docker pull zzrot/whale-awkward
    run docker pull zzrot/alpine-ghost
    run docker pull zzrot/alpine-node
    run docker run -d zzrot/alpine-caddy
}

function clean() {
  run docker kill $(docker ps -a -q)
  run docker rm -f $(docker ps -a -q)
  run docker rmi -f $(docker images -aq)
}
