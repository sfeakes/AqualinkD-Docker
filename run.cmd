
docker run -t --rm -i --name AqualinkD \
    -v /var/run/systemd/journal/socket:/var/run/systemd/journal/socket \
    -v /var/log/journal:/var/log/journal:ro \
    -v /etc/localtime:/etc/localtime:ro \
    --mount type=bind,source=/nas/data/Development/Raspberry/AqualinkD-Docker/aqualinkd.conf,target=/etc/aqualinkd.conf \
    --mount type=bind,source=/nas/data/Development/Raspberry/AqualinkD-Docker/aqualinkd.cron,target=/etc/cron.d/aqualinkd \
    -p 8080:80 \
    --device /dev/ttyUSB0:/dev/ttyUSB0 \
    -e config=/etc/aqualinkd.conf aqualinkd

#docker run -it --rm --name AqualinkD -p 8080:80 --device=/dev/ttyUSB0 -e "config=/aquacfg/aqualinkd.conf" --mount type=bind,source="$(pwd)",target=/aquacfg aqualinkd
