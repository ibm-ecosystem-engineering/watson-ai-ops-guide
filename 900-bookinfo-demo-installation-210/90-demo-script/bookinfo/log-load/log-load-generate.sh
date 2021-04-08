#!/bin/bash

echo "log load started ..... $(date)"

source ./config.sh

##### Call book info 
ab -n 200 -c 5 $APP_URL

echo "log load  completed ..... $(date)"

