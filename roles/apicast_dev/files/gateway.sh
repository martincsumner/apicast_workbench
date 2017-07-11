#!/bin/sh

APICAST_LOG_FILE=logs/error.log
APICAST_MANAGEMENT_API=debug
#VARS

export APICAST_LOG_FILE
export THREESCALE_PORTAL_ENDPOINT
export RHSSO_ENDPOINT
export APICAST_MANAGEMENT_API

cd $ROOT_DIR || exit 2
ulimit -n 32000

case $1 in
  start)
    echo Starting apicast gateway
    bin/apicast -d  -vvv
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
