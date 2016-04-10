#!/usr/bin/env bash

# Tests using the shUnit2 BASH testing framework
# shUnit Documentation: https://shunit2.googlecode.com/svn/trunk/source/2.1/doc/shunit2.html
#declare machineRunning=false

: '
setUp() {
  machineRunning = docker-machine env | sed '*s/[^no]*'
  echo Machine Running: $machineRunning
  if [ ! machineRunning ]; then
    docker-machine start
    echo got here
  fi
  docker-machine env

}
# This is a test with one of more asserts
testMyComparison() {
  .././docker-clean

  # "Executing 3 Asserts..."
  assertTrue "This is the message if it fails" " [ 1 -eq 1 ]"
  # Add asserts here ...

}
'



# Execute shunit2 to run the testSampleScriptParameters
#. shunit2
#. shunit2-2.1.6/src/shunit2
