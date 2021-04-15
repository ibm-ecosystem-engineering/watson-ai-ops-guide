#!/bin/bash
echo "Process started ...."

source ./00-config.sh

echo "START_TIME : $START_TIME "

TIME_INDEX=$START_TIME 
echo "TIME_INDEX : $TIME_INDEX "

##  Create temp folder and go inside
rm -rfd temp-gan
mkdir temp-gan


for (( minutesIndex=1; minutesIndex<=$TOTAL_MINUTES; minutesIndex++ ))
do
	echo "minutesIndex -------: $minutesIndex "
    for secondsIndex in {1..59}
    do
        FULL_URL="${URL_PART_1}${TIME_INDEX}000${URL_PART_2}${TIME_INDEX}999${URL_PART_3}"
        echo "URL => $FULL_URL"
        TIME_INDEX=$(($TIME_INDEX + 1))

        # curl "$FULL_URL" -u $LOG_DNA_KEY >> ./temp-gan/myLog-$TIME_INDEX-$minutesIndex-$secondsIndex.txt
        curl "$FULL_URL" -u $LOG_DNA_KEY >> ./temp-gan/myLog.json
    done
done

echo "Process completed ...."