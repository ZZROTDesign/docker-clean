#!/bin/bash
#          OPTIONS="Hello Quit"
#          select opt in $OPTIONS; do
#              if [ "$opt" = "Quit" ]; then
#               echo done
#               exit
#              elif [ "$opt" = "Hello" ]; then
#               echo Hello World
#              else
#               clear
#               echo bad option
#              fi
#          done
function count {
  runningContainers="$(docker images -aq)"  #"$(docker ps -qf STATUS=exited )" #"$(docker ps -q)"
  length=${#runningContainers[@]}
  number_of_occurrences=$(grep -o "" <<< "$runningContainers" | wc -l)
  echo $runningContainers
  echo $number_of_occurrences
  declare -p $runningContainers 2> /dev/null | grep -q '^declare \-a' && echo array || echo array not found

}

count

function cleanContainers {
    stoppedContainers="$(docker ps -qf STATUS=exited )"
		createdContainers="$(docker ps -qf STATUS=created)"
		stopped_count=$(count stoppedContainers)
		created_count=$(count createdContainers)
    if [ ! "$stoppedContainers" ]; then
        echo No Containers To Clean!
    else
				echo Cleaning containers...
        docker rm $stoppedContainers &>/dev/null
				echo Stopped containers cleaned: $stopped_count
    fi

		if [ "$createdContainers" ]; then
			docker rm $createdContainers &>/dev/null
			echo Created containers cleaned: $created_count
		fi
}
