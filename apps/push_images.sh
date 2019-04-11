#!/bin/bash

echo "##########################"
echo "### Push docker images ###"
echo "##########################"
echo

docker login --username $1 --password $2

docker-compose build --no-cache
docker-compose push
