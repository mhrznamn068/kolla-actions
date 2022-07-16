#!/bin/bash

kolla-ansible pull

docker images | grep kolla | grep -v local | awk '{print $1,$2}' | while read -r image tag; do
    docker tag ${image}:${tag} $1:$2/${image}:${tag}
    docker push $1:$2/${image}:${tag}
done
