#!/usr/bin/env bash

### Start Time : Friday, 16 April 2021 01:10:00 GMT+05:30
START_TIME=1618515600

### Total minutes. 
### When the start time is 1:10, total minutes 10 means, it will download from 1:10 to 1:20
TOTAL_MINUTES=10

### Log DNA Key
LOG_DNA_KEY=


# URL="https://api.eu-gb.logging.cloud.ibm.com/v1/export?from=1618472520&to=1618472639&size=50000" -u dummy > log.txt
URL_PART_1="https://api.eu-gb.logging.cloud.ibm.com/v1/export?prefer=head&from="
URL_PART_2="&to="
URL_PART_3="&size=10000"
