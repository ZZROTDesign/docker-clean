#!/usr/bin/env bats

# Initial pass at testing for docker-clean
# These tests simply test each of the options currently available

# To run the tests locally run brew install bats or
# sudo apt-get install bats and then bats batsTest.bats

@test "Check that docker client is available" {
  command -v docker
}

@test "Check that we have a /tmp directory" {
  run stat /tmp
  [ $status = 0 ]
}

@test "Check that total is listed" {
  run ls -l
  [[ ${lines[0]} =~ "total" ]]
}

@test "Run docker ps" {
  run docker ps
  [ $status = 0 ]
}


@test "Docker Clean Version echoes" {
  run ../docker-clean -v
  [ $status = 0 ]
}

@test "Help menu opens" {
  # On -h flag
  run ../docker-clean -h
  [[ ${lines[0]} =~ "Options:" ]]
  run ../docker-clean --help
  [[ ${lines[0]} =~ "Options:" ]]
  # On unspecified tag
  run ../docker-clean -z
  [[ ${lines[0]} =~ "Options:" ]]
}

@test "Test container stopping (-s --stop)" {
  build
  [ $status = 0 ]
  
}


# Helper FUNCTIONS
function build() {
    run docker rm -f $(docker ps -a -q)
    run docker pull zzrot/whale-awkward
    run docker pull zzrot/alpine-caddy
    run docker pull zzrot/alpine-node
    run docker run -d ghost
}

function clean() {
  run docker kill $(docker ps -a -q)
  run docker rm -f $(docker ps -a -q)
  run docker rmi -f $(docker images -aq)
}
