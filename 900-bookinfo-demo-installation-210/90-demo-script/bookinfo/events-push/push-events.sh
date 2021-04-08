#!/bin/bash

echo "create events started ..... $(date)"

source ./config.sh

JSON_PATH=@./events-push

pushEvent() {
    JSON_FILE=$1
    OUTPUT_FILE=$2

    curl --silent -X POST -v -u root:$EVENT_PASSWORD -H "$H_ACCEEPT" -H "$H_CONTENT" -d $JSON_PATH/$JSON_FILE $URL_EVENT_MGR
}

pushEvent "ratings_pod_down.json" "1.txt"
pushEvent "ratings_deployment_down.json" "2.txt"

echo "create events completed ..... $(date)"
