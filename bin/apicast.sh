#!/bin/sh

##########
#### Hacky script to start and stop the gateway
#########


#1. You will need to change these vars to match your 3Scale account
#   pick and choose the env. vars you wish to use.

ROOT_DIR=/vagrant/apicast-3.0.0/apicast
THREESCALE_PORTAL_ENDPOINT=https://<YOUR _ACCESS_TOKEN>@<YOUR_ACCOUNT-admin.3scale.net>
APICAST_MANAGEMENT_API=debug
#REDIS_HOST=192.168.33.10
#REDIS_PORT=6379

#set this to the name of your custom lua mod. and be sure to export it below.
#APICAST_MODULE=custom_header

APICAST_LOG_FILE=logs/error.log
APICAST_MANAGEMENT_API=debug
#VARS

#2. check that the vars you want are being exported
export APICAST_LOG_FILE
export THREESCALE_PORTAL_ENDPOINT
#export RHSSO_ENDPOINT
export APICAST_MANAGEMENT_API
#export APICAST_MODULE
#export REDIS_PORT
#export REDIS_HOST

cd $ROOT_DIR || exit 2
ulimit -n 32000

case $1 in
  start)
    echo Starting apicast gateway
    bin/apicast   -vvv
  ;;

  stop)
    echo Stopping apicast gateway
    pkill -f nginx:
  ;;

  restart)
    echo Restarting apicast gateway
    pkill -f nginx:
    sleep 3
    bin/apicast -d  -vvv
  ;;

esac
