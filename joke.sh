#!/bin/bash

trap 'echo "try stop success:0"'  SIGINT

while :
do
        echo "WARNING: Disk formatting!"
        sleep 1
done
