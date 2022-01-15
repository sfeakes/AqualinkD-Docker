# AqualinkD-Docker
Docker info for Aqualinkd

## Very quick information of running AqualinkD with docker ##
The information below will let you create a docker image to run, I'm not going to go into all the details as to why I'm not deploying a container.  So this will be a little more involved if you've only consumed other peoples containers before.

All files are in the repo.  Firt thing you need is to get the Dockerfile & AqualinkD config, then you can build the image, once build you can then run the image.

Basic steps in a terminal would be sthe below.
```
mkdir ~/AuqalinkD-Docker
cd ~/AuqalinkD-Docker
wget https://raw.githubusercontent.com/sfeakes/AqualinkD-Docker/main/Dockerfile
wget https://raw.githubusercontent.com/sfeakes/AqualinkD/master/release/aqualinkd.conf 

sudo docker build -t aqualinkd .
```

That will pull a gcc compiler image, AqualinkD from githib, and then build AqualinkD from source.

If that worked, you can now run the image.
```
cd ~/AuqalinkD-Docker
docker run -it --rm --name AqualinkD -p 8080:80 --device=/dev/ttyUSB0 -e "config=/aquacfg/aqualinkd.conf" --mount type=bind,source="$(pwd)",target=/aquacfg aqualinkd
```

The build and run commands are in the build.cmd & run.cmd files in the repo as well.

That will get you to the point where you need to read the AqualinkD wiki about configuration.
You will obviously need to change /dev/ttyUSB0 and -p8080:80 to what ever port you want to map.




