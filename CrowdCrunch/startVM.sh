#!/bin/bash

#  startDocker.sh
#  CrowdCrunch
#
#  Created by HackReactor on 11/13/14.
#  Copyright (c) 2014 HackReactor. All rights reserved.


echo 'STARTING VM...'
cd /.CrowdCrunch

#ip fuckery
#SHELL_ARGS="run 'a:1;b:2'" vagrant up --provision

#can't stop, won't stop
vagrant up
#echo "run '$1'"
SHELL_ARGS="run '$1'" vagrant provision

#PATH_TO_DOCKER="~/Documents"
#print variable on a screen
#echo "TEST";
#PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin;
#echo '\a';
#printf '\a';
#install virtual box and vagrant
#export DOCKER_CERT_PATH=/Users/hackreactor/.boot2docker/certs/boot2docker-vm; #this needs to change per user
#export DOCKER_TLS_VERIFY=1;
#export DOCKER_HOST=tcp://192.168.59.103:2376;
#boot2docker start;
#docker ps -a;
#docker start dcacf3c3224d;
#docker attach dcacf3c3224d;
