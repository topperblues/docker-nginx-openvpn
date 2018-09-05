#!/bin/bash

#
# Create tun fo openvpn
#

mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
    mknod /dev/net/tun c 10 200
fi


# Start nginx process
echo "Start nginx process"
nginx -c /etc/nginx/nginx.conf
status=$?

echo "Nginx status: $status"

if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit 1
fi

# Start openvpn process
echo "Start openvpn process"
(openvpn --config /etc/openvpn/client.ovpn --verb 0) &
status=$?
  echo "Openvpn status: $status"

if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit 1
fi


# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container exits with an error
# if it detects that either of the processes has exited.
# Otherwise it loops forever, waking up every 60 seconds

while sleep 60; do
  ps aux |grep nginx |grep -q -v grep
  NGINX_STATUS=$?
  ps aux |grep openvpn |grep -q -v grep
  OPENVPN_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $NGINX_STATUS -ne 0 -o $OPENVPN_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done