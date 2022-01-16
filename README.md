# AqualinkD-Docker
Docker info for Aqualinkd  
Please note this not not the best way to run AqualinkD, you are far better off downloading the git repo and running make & make install on your system. (information on this is in the AqualinkD wiki)

## Very quick information of running AqualinkD with docker ##

### This should be considered beta at present ###
The information below will let you create a docker image to run, I'm not going to go into all the details as to why I'm not deploying a container.  So this will be a little more involved if you've only consumed other peoples containers before.

All files you need are in this repo.  First thing you need is to get the `docker-compose.yml` & `aqualinkd.conf` file, then you can build the image, once built you can then run the image like you would any other container.

#
## Using docker-compose ##

docker-compose.yml
```
version: '3.2'
services:
  aqualinkd:
    build:
      context: https://github.com/sfeakes/AqualinkD-Docker.git#main
    ports:
      - "8080:80"
    volumes:
      - type: bind
        source: ./aqualinkd.conf
        target: /aquacfg/aqualinkd.conf
        read_only: true
    environment:
      config: /aquacfg/aqualinkd.conf
    devices:
      - "/dev/ttyUSB0:/dev/ttyUSB0"
```

Make sure aqualinkd.conf is in the current directory (or referanced correctly in the yml file), then build
```
sudo docker-compose up --build
```
#
## Using docker ##

All files you need are in this repo. First thing you need is to get the `Dockerfile` & `aqualinkd.conf` files, then you can build the image, once built you can then run the image like you would any other container.

Basic steps in a terminal would be the below.
```
mkdir ~/AuqalinkD-Docker
cd ~/AuqalinkD-Docker
wget https://raw.githubusercontent.com/sfeakes/AqualinkD-Docker/main/Dockerfile
wget https://raw.githubusercontent.com/sfeakes/AqualinkD-Docker/main/aqualinkd.conf 

sudo docker build -t aqualinkd .
```

That will pull a gcc compiler image, AqualinkD from githib, and then build AqualinkD from source within the docker image

If that worked, you can now run the image with the below command.
```
cd ~/AuqalinkD-Docker
sudo docker run -it --rm --name AqualinkD -p 8080:80 --device=/dev/ttyUSB0 -e "config=/aquacfg/aqualinkd.conf" --mount type=bind,source="$(pwd)",target=/aquacfg aqualinkd
```
Few things to note, AqualinkD needs a config file, you are passing that to the container with the `--mount` command, (ie container is mounting the local directory) so aqualinkd.conf must exist in the directory you pass. AqualinkD's default web port is 80, the `-p 8080:80` is mapping container port 80 to local port 8080, since no ip is listed before 8080, if will be available to any maching on your network.  If you change the aqualinkd.conf file, make sure to change this parameter as well.

The build and run commands are in the build.cmd & run.cmd files in the repo as well.

That will get you to the point where you need to read the AqualinkD wiki about configuration.
You will obviously need to change /dev/ttyUSB0 and -p8080:80 to what ever port you want to map.




