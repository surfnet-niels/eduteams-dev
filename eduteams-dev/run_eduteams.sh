#! /bin/bash
IMAGE_TAG=eduteams/teip:v1

# Setup the netwerk if needed
if [ ! "$(docker network ls | grep eduteams.local)" ]; then
  echo "Creating eduteams.local network ..."
  ../dockernet.sh
else
  echo "eduteams.local network exists."
fi

# Build the docker image if needed
if [[ "$(docker images -q $IMAGE_TAG 2> /dev/null)" == "" ]]; then
  docker build -t $IMAGE_TAG .
fi

# find the location of configs in current directory structure
RUN_DIR=$PWD
CONFIG_DIR="$RUN_DIR/config"

# Start SVS
docker run -it \
	--net eduteams.local \
	--hostname proxy.eduteams.local \
        --ip 172.128.128.10 \
	-v $PWD/workdir:/opt/workdir \
	-e DATA_DIR=/var/eduteams \
	-w /var/eduteams \
	-v $PWD/debian:/home/debian \
	$IMAGE_TAG


    #--add-host=rp.eduteams.local:10.128.128.100 \
	#--add-host=idp.eduteams.local:10.128.128.200 \

	#-v $CONFIG_DIR/production:/var/eduteams \
	#-v $CONFIG_DIR/cdb:/etc/cdb \
	#-e DATA_DIR=/var/eduteams \
	#-w /var/eduteams \


