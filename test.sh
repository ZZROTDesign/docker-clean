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
function counter {
  runningContainers="$(docker ps -a -q)" #"$(docker images -aq)"  #"$(docker ps -qf STATUS=exited )" #"$(docker ps -q)"
  length=${#runningContainers[@]}
  number_of_occurrences=$(grep -o "" <<< "$runningContainers" | wc -l)
  echo $runningContainers
  echo $number_of_occurrences
  declare -p $runningContainers 2> /dev/null | grep -q '^declare \-a' && echo array || echo array not found

}

echo $running_Count

function count {
    echo got here
		toCount="$1"
    echo arg passed: $toCount
		number_of_occurrences=$(grep -o "" <<< "$toCount" | wc -l)
		echo $number_of_occurrences
}
runningContainers="$(docker ps -a -q)"
number=$(count "$runningContainers")
echo $number
#count

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
