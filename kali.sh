#!/bin/bash

start_kali() {
	docker run -dt xpatterns/kali-linux-docker 
}

stop_all_dockers() {
        containers=`docker ps -q`
        if [[ $containers ]]; then
           echo 'Stopping all containers..'
                docker stop $containers
        else
           echo 'No running dockers to stop'
        fi
	exit $?;
}

ssh_docker(){
	docker exec -it $(docker ps -q) bash
}

kill_dockers(){
	# Kill all the running containers
	echo -e "\n ---- Killing all containers ---- \n"
	 docker kill $(docker ps -q)
	echo -e "\n ---- Killing complete ---- \n"
}

clean_images() {
        containers=`docker ps -a -q`
        images=`docker images -a -q`
        if [[ $containers ]]; then
                `docker rm -f $containers`
        fi
        if [[ $images ]]; then
                `docker rmi -f $images`
        fi
}

status() {
	echo  -e "\n ---- Status of Kali Dockers ---- \n"
	docker ps --format "{{.Image}}: {{.Status}}"
 	echo  -e "\n -------- \n"
}

print_usage() {
echo -e \
"Usage: kali.sh COMMAND \n\
where COMMAND is one of: \n\
  status 		get information on running kali containers \n\
  start 		start the latest kali container \n\
  stop 			stop one or all of running kali containers 	\n\
  enter			launch a bash shell into a running kali container \n\
  clean 		kill all running kali containers and clean images \n "
exit 1;
}



if [ "$#" -lt 1 ]; then
   print_usage
   exit 1;
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

case "$1" in
	"clean" ) 
		kill_dockers  
		clean_images
		;;
	"enter" )
		ssh_docker 
		;;
	"stop" )
                stop_all_dockers 
		;;
	"start" )
                start_kali
                ;;
	"status" )
		status
		;;
		
       	*) 	print_usage
		;;
esac

