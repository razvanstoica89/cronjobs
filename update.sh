#!/bin/bash

alpine=$(curl -L -s 'https://registry.hub.docker.com/v2/repositories/library/alpine/tags?page_size=1024'|jq -r '."results"[]["name"]')
cronjobs=$(curl -L -s 'https://registry.hub.docker.com/v2/repositories/razvanstoica/cronjobs/tags?page_size=1024'|jq -r '."results"[]["name"]')

for i in $alpine; do
    if grep -w -x -q $i <<< $cronjobs
    then
        echo "A tag called $i found"
    else
        version=$i
        template="$(cat dockerfile.template)"
        eval "echo \"${template}\"" > build-image/dockerfile
        git add .
        git commit -m "Update to Alpine version $i"
        git tag -a $i -m "Update to Alpine version $i"
    fi
done

git push origin --tags
git push
