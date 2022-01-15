docker run -it --rm --name AqualinkD -p 8080:80 --device=/dev/ttyUSB0 -e "config=/aquacfg/aqualinkd.conf" --mount type=bind,source="$(pwd)",target=/aquacfg aqualinkd
