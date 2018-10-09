#! /bin/bash
IMAGE_TAG=eduteams/ssp-client:v1
CONTAINER_NAME=eduteams_client

# Setup the netwerk if needed
if [ ! "$(docker network ls | grep eduteams.local)" ]; then
  echo "Creating eduteams.local network ..."
  ./dockernet.sh
else
  echo "eduteams.local network exists."
fi

# Build the docker image if needed
if [[ "$(docker images -q $IMAGE_TAG 2> /dev/null)" == "" ]]; then
  echo "Creating $IMAGE_TAG docker container ..."
  docker build -t $IMAGE_TAG .
else
  echo "$IMAGE_TAG docker container exists..."
fi

# Start SSP IDP
docker start -i $CONTAINER_NAME || docker run -it \
    --name $CONTAINER_NAME \
	--net eduteams.local \
	--ip 172.128.128.11 \
	--add-host=idp.eduteams.local:172.128.128.11 \
	--add-host=sp.eduteams.local:172.128.128.11 \
	--hostname client.eduteams.local \
	--expose 80 \
	--expose 443 \
	$IMAGE_TAG
