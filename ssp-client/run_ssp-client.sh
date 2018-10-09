#! /bin/bash
IMAGE_TAG=eduteams/ssp-client:v1

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
docker run \
	--net eduteams.local \
        --ip 172.18.128.100 \
	--ip 172.18.128.200 \
	--add-host=idp.eduteams.local:172.18.128.100 \
	--add-host=sp.eduteams.local:172.18.128.200 \
	--hostname client.inacademia.local \
	--expose 80 \
	--expose 443 \
	-it $IMAGE_TAG
