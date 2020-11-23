# Cronjobs

![GitHub](https://img.shields.io/github/license/razvanstoica89/cronjobs)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/razvanstoica89/cronjobs/main)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/razvanstoica89/cronjobs?label=release)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/razvanstoica/cronjobs)
![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/razvanstoica/cronjobs)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/razvanstoica/cronjobs)

A minimal Docker image based on [Alpine Linux](https://hub.docker.com/_/alpine) with curl for cronjobs

## Usage

Create a docker-compose.yml with:

```
version: '3'

services:
    cronjobs:
      restart: unless-stopped
      image: razvanstoica/cronjobs:3
      container_name: <your container name goes here>
      volumes:
        - ./crontabs/root:/etc/crontabs/root
```

Put your cronjobs in ./crontabs/root file.

Run it with ```docker-compose up``` command.

## Logs

Set the output to ```/dev/stdout``` in order to view the cron result.

Example: ```* * * * * curl -s4 ifconfig.co > /dev/stdout```.

Read all the logs with ```docker logs <your container name goes here>```.

In order to persist the logs you can add a new volume like this:
```
version: '3'

services:
    cronjobs:
      restart: unless-stopped
      image: razvanstoica/cronjobs:3
      container_name: <your container name goes here>
      volumes:
        - ./crontabs/root:/etc/crontabs/root
        - ./log:/var/log/
```
Set the output to ```/var/log/<your log file name goes here>``` in order to view the cron result.

Example: ```* * * * * curl -s4 ifconfig.co > /var/log/<your log file name goes here>``` 

## Contributing

Feel free to contribute.

## Versioning scheme

Same as [Alpine Linux](https://hub.docker.com/_/alpine).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for detail

## Authors

* [Razvan Stoica](https://gitlab.com/razvan.stoica89) - *Initial work*

See also the list of [contributors](https://github.com/razvanstoica89/cronjobs) who participated in this project.

## Changelog

See the full change log [here](https://github.com/razvanstoica89/cronjobs/releases).
