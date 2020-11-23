#!/bin/bash

alpine=$(curl -L -s 'https://registry.hub.docker.com/v2/repositories/library/alpine/tags?page_size=1024'|jq -r '."results"[]["name"]')
cronjobs=$(curl -L -s 'https://registry.hub.docker.com/v2/repositories/razvanstoica/cronjobs/tags?page_size=1024'|jq -r '."results"[]["name"]')

# Ignore old Alpine Linux tags
ignored_versions="edge 20200917 20200626 3.12.0 20200428 3.9.6 3.9 3.11.6 3.11 3.10.5 3.10 3.11.5 20200319 3.9.5 3.8.5 3.8 3.10.4 20200122 3.11.3 3.11.2 3.11.0 20191219 20191114 3.10.3 20190925 3.10.2 3.8.4 20190809 3.10.1 20190707 3.9.4 3.7.3 3.7 3.10.0 20190508 3.6.5 3.6 3.9.3 20190408 3.9.2 20190228 3.5 3.4 3.3 3.2 3.1 2.7 2.6"
cronjobs="$cronjobs $ignored_versions"

update(){
   version=$1
   template="$(cat dockerfile.template)"
   eval "echo \"${template}\"" > build-image/dockerfile
}

for i in $alpine; do
    if grep -w -q $i <<< $cronjobs
    then
        echo "A tag called $i found"
    else
        update $i
        git add .
        git commit -m "Update to Alpine version $i"
        git tag -a $i -m "Update to Alpine version $i"
    fi
done

update latest

# git push origin --tags
# git push
