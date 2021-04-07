#!/usr/bin/env bash

source ./00-config.sh
source ./00-process.sh

fetchId() {
    UNIQUE_ID_TO_SEARCH=$1
    cat ./00-ids.json |  jq -r "._items[] | select(.uniqueId==\"$UNIQUE_ID_TO_SEARCH\") | ._id "  > ./temp-gan/$UNIQUE_ID_TO_SEARCH.txt
    resultValue="$(cat ./temp-gan/$UNIQUE_ID_TO_SEARCH.txt)"
    echo $resultValue
}

createLinkForDeployPodService() {
    MICRO_SERVICE_NAME=$1

    deployment_id=$(fetchId "$MICRO_SERVICE_NAME-deployment-id")
    pod_id=$(fetchId "$MICRO_SERVICE_NAME-pod-id")
    svc_id=$(fetchId "$MICRO_SERVICE_NAME-svc-id")

    echo "$MICRO_SERVICE_NAME"

    ### "1. Creating Links between (DEPLOYMENT --> POD)"
    createLink_DependsOn $deployment_id $pod_id

    ### "2. Creating Links between (SVC --> POD) "
    createLink_DependsOn $svc_id $pod_id
}

createLinkForDeployToDeploy() {
    MICRO_SERVICE_NAME1=$1
    MICRO_SERVICE_NAME2=$2

    deployment_id1=$(fetchId "$MICRO_SERVICE_NAME1-deployment-id")
    deployment_id2=$(fetchId "$MICRO_SERVICE_NAME2-deployment-id")

    echo "$MICRO_SERVICE_NAME1  ---> $MICRO_SERVICE_NAME2"

    # echo $deployment_id1
    # echo $deployment_id2

    # ### "1. Creating Links between (DEPLOYMENT --> DEPLOYMENT)"
    createLink_DependsOn $deployment_id1 $deployment_id2
}

updateMatchToken_new() {
    MICRO_SERVICE_NAME=$1

    deployment_id=$(fetchId "$MICRO_SERVICE_NAME-deployment-id")
    pod_id=$(fetchId "$MICRO_SERVICE_NAME-pod-id")
    svc_id=$(fetchId "$MICRO_SERVICE_NAME-svc-id")

    echo "$MICRO_SERVICE_NAME"
    # echo $deployment_id
    # echo $pod_id
    # echo $svc_id

    updateMatchToken "$MICRO_SERVICE_NAME-deployment-id" $deployment_id
    updateMatchToken "$MICRO_SERVICE_NAME-pod-id" $pod_id
    updateMatchToken "$MICRO_SERVICE_NAME-svc-id" $svc_id
}

processAll() {
    echo "1. Creating Links between (DEPLOYMENT --> POD)"
    echo "2. Creating Links between (SVC --> POD) "
    createLinkForDeployPodService "$SERVICE_PRODUCT_PAGE" 
    createLinkForDeployPodService "$SERVICE_REVIEWS_V1"
    createLinkForDeployPodService "$SERVICE_REVIEWS_V2"
    createLinkForDeployPodService "$SERVICE_REVIEWS_V3"
    createLinkForDeployPodService "$SERVICE_DETAILS"
    createLinkForDeployPodService "$SERVICE_RATINGS"

    echo "3. Creating Links between (DEPLOYMENT --> DEPLOYMENT) "
    createLinkForDeployToDeploy "$SERVICE_PRODUCT_PAGE" "$SERVICE_REVIEWS_V1"
    createLinkForDeployToDeploy "$SERVICE_PRODUCT_PAGE" "$SERVICE_REVIEWS_V2"
    createLinkForDeployToDeploy "$SERVICE_PRODUCT_PAGE" "$SERVICE_REVIEWS_V3"
    createLinkForDeployToDeploy "$SERVICE_PRODUCT_PAGE" "$SERVICE_DETAILS"

    createLinkForDeployToDeploy "$SERVICE_REVIEWS_V1" "$SERVICE_RATINGS"
    createLinkForDeployToDeploy "$SERVICE_REVIEWS_V2" "$SERVICE_RATINGS"
    createLinkForDeployToDeploy "$SERVICE_REVIEWS_V3" "$SERVICE_RATINGS"

    echo "4. update Match Token "
    updateMatchToken_new "$SERVICE_PRODUCT_PAGE" 
    updateMatchToken_new "$SERVICE_REVIEWS_V1"
    updateMatchToken_new "$SERVICE_REVIEWS_V2"
    updateMatchToken_new "$SERVICE_REVIEWS_V3"
    updateMatchToken_new "$SERVICE_DETAILS"
    updateMatchToken_new "$SERVICE_RATINGS"

}

doFetchMain() {
    rm -rfd temp-gan
    mkdir temp-gan

    processAll 

    rm -rfd temp-gan
}

doFetchMain

