# AqualinkD-Docker

Please see the AqualinkD wiki docker section for how to build / deploy AqualinkD with a docker.
[Wiki - Docker](https://github.com/sfeakes/AqualinkD/wiki#Docker)

This repo simply holds docker development tools for AqualinkD and no documentation provided. look / play / re-use anything here as you desire.

* Dockerfile <-- Used to build your own AqualinkD container for local deployment. 
* Dockerfile.releaseBinaries <-- Used for compiling armhf and arm64 binaries for AqualinkD
* Dockerfile.buildx <-- Used to create arm64 & amd64 AqalinkD containers for docker.io
* Dockerfile.* <-- Playing / testing / previous version of above

<!--

Docker info for Aqualinkd  
Please note this not not the best way to run AqualinkD, you are far better off downloading the git repo and running make & make install on your system. (information on this is in the AqualinkD wiki)

## Very quick information of running AqualinkD with docker ##


# Below is out of date, please see AqualinkD wiki for information #

### This should be considered pre-release / beta at present ###
First you will need access to the USB2RS485 adapter, If you’re running Linux, this is as simple as adding --device /dev/ttyUSBx to the docker run command. It’s not that simple on OSX or Windows. That’s because the docker daemon only runs natively on Linux. For other operating systems it is run in a hypervisor or virtual machine. In order to expose the port to the container, you first have to expose it to the virtual machine / hypervisor where Docker is running. Unfortunately that's not possible under OSX, and seems to have lots of problems with windows. Since it is absilutly imperitive for AqualinkD to have a very solid and fast connection to the USB2RS485 adapter, <b>it is not advised to run AqualinkD in a docker on any OS other than linux.</b>

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

-->




