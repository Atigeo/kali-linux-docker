#!/bin/bash

sudo docker build -t atigeo/kali-linux-docker . 
#TAG=$(sudo docker run -t -i atigeo/kali-linux-docker awk '{print $NF}' /etc/debian_version | sed 's/\r$//' ) 
#echo "Tagging kali with $TAG" &&\
#sudo docker tag atigeo/kali-linux-docker:latest atigeo/kali-linux-docker:$TAG &&\
#echo "Build OK" || echo "Build failed!"
