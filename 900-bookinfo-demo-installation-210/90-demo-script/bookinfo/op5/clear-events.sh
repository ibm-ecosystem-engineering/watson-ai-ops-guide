#!/bin/bash

echo "clear events started ..... $(date)"


source ./config.sh

KEY_FIELD1=$(cat temp/1.txt)
KEY_FIELD2=$(cat temp/2.txt)
KEY_FIELD3=$(cat temp/3.txt)
KEY_FIELD4=$(cat temp/4.txt)

clearEvent() {
    KEY_FIELD=$1
    curl --silent -X DELETE -v -u root:$EVENT_PASSWORD -H "$H_ACCEEPT" -H "$H_CONTENT" $URL_EVENT_MGR/kf/$KEY_FIELD
}

echo "Deleting key field : $KEY_FIELD1" 
clearEvent $KEY_FIELD1
clearEvent $KEY_FIELD2
clearEvent $KEY_FIELD3
clearEvent $KEY_FIELD4

rm ./temp/1.txt
rm ./temp/2.txt
rm ./temp/3.txt
rm ./temp/4.txt

echo "clear events completed ..... $(date)"
