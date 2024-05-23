#!/bin/bash

IMAGE=aqualinkd

if [ $# -eq 0 ]
  then
    VERSION=$(curl --silent "https://api.github.com/repos/sfeakes/AqualinkD/releases/latest" | grep -Po '"tag_name": "[^0-9]*\K.*?(?=")')
  else
    VERSION=$1
fi

URL="https://github.com/sfeakes/AqualinkD/archive/refs/tags/v"$VERSION".tar.gz"
URL2="https://github.com/sfeakes/AqualinkD/archive/refs/tags/V"$VERSION".tar.gz"
BURL="https://github.com/sfeakes/AqualinkD/archive/refs/heads/"$VERSION".tar.gz"

# Check version is accurate before dunning docker build
if curl --output /dev/null --silent --location --head --fail "$URL"; then
  echo "Building Docker container for $IMAGE $VERSION"
else
  # Check if version tag has wrong case
  if curl --output /dev/null --silent --location --head --fail "$URL2"; then
    echo "Building Docker container for $IMAGE using branch $VERSION"
    URL=$URL2
  else
    # Check if it's a branch
    if curl --output /dev/null --silent --location --head --fail "$BURL"; then
      echo "Building Docker container for $IMAGE using branch $VERSION"
      URL=$BURL
    else
      echo "ERROR Can't build Docker container for $IMAGE $VERSION"
      echo -e "Neither Version or Branch URLs:- \n $URL \n $BURL"
      exit 1
    fi
  fi
fi

docker build -t ${IMAGE}:${VERSION} --build-arg AQUALINKD_VERSION=${VERSION} --build-arg AQUALINKD_SOURCE=${URL} .
docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest

# Remove untagged images 
#docker rmi $(docker images | grep "^<none>" | awk '{print $3}')

exit 0

# USe below to push image
docker tag local-image:tagname new-repo:tagname
docker push new-repo:tagname
