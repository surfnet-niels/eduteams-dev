#! /bin/bash

IMAGE_TAG=eduteams/teip:v1

# create workdir
if ! [ -f debian/.ssh/authorized_keys ]; then
    mkdir -p debian/.ssh
    cp ~/.ssh/id_rsa.pub debian/.ssh/authorized_keys
    chmod 700 debian/.ssh
fi

# As the build command is being called, we assume we need to build a new image.
# To be sure we therefor first remove existign ones
if [[ "$(docker images -q $IMAGE_TAG 2> /dev/null)" != "" ]]; then
  echo "Removing existing $IMAGE_TAG docker container ..."
  docker rmi -f $IMAGE_TAG
fi

echo "Building  docker container $IMAGE_TAG ..."
# Build the docker image
docker build -t $IMAGE_TAG .

