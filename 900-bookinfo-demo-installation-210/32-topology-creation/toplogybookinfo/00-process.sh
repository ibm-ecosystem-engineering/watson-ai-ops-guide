#!/usr/bin/env bash

createNode() {
    PARAM_ENTITY_TYPE=$1
    PARAM_NAME=$2
    PARAM_MATCH_TOKEN=$3
    PARAM_UNIQUE_ID=$4

    JSON_DATA=" \"app\": \"$DATA_APP\",\"dataCenter\": \"$DATA_CENTER\" , \"entityTypes\": [\"$PARAM_ENTITY_TYPE\"],  \"matchTokens\": [\"$PARAM_MATCH_TOKEN-v1\"],  \"name\": \"$PARAM_NAME\", \"namespace\": \"$DATA_NAMESPACE\", \"uniqueId\": \"$PARAM_UNIQUE_ID\",  \"availableReplicas\": 1,\"createdReplicas\": 1, \"desiredReplicas\": 1, \"readyReplicas\": 1,\"tags\": [\"app:$DATA_APP\",\"namespace:$DATA_NAMESPACE\"],\"vertexType\": \"resource\" "

    curl -X POST --insecure -u $NOI_REST_USR:$NOI_REST_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: $TENENT_ID"  --header "JobId: $JOB_ID" -d "{$JSON_DATA}" "$URL_PREFIX/resources"
}


createDeploymentPodService() {
    MICRO_SERVICE_NAME=$1

    echo "Node creation for : $MICRO_SERVICE_NAME"
    createNode "deployment" "$MICRO_SERVICE_NAME" "$MICRO_SERVICE_NAME" "$MICRO_SERVICE_NAME-deployment-id"
    createNode "pod" "$MICRO_SERVICE_NAME" "$MICRO_SERVICE_NAME" "$MICRO_SERVICE_NAME-pod-id"
    createNode "service" "$MICRO_SERVICE_NAME" "$MICRO_SERVICE_NAME" "$MICRO_SERVICE_NAME-svc-id"
}

## method
createLink() {
    FROM_ID=$1
    TO_ID=$2
    CONNECT_TYPE=$3

    echo "MY URL : $URL_PREFIX/resources/$FROM_ID/references/out/$CONNECT_TYPE/$TO_ID"

    curl -X POST --insecure -u $NOI_REST_USR:$NOI_REST_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: ${TENENT_ID}" -d "{}" "$URL_PREFIX/resources/$FROM_ID/references/out/$CONNECT_TYPE/$TO_ID"
}

deleteNode() {
    PARAM_ENTITY_TYPE=$1
    PARAM_NAME=$2
    PARAM_MATCH_TOKEN=$3
    PARAM_UNIQUE_ID=$4
    PARAM_TAG_APP=$5

    JSON_DATA=" \"app\": \"$DATA_APP\",\"dataCenter\": \"$DATA_CENTER\" , \"entityTypes\": [\"$PARAM_ENTITY_TYPE\"],  \"matchTokens\": [\"$PARAM_MATCH_TOKEN-v1\"],  \"name\": \"$PARAM_NAME\", \"namespace\": \"$DATA_NAMESPACE\", \"uniqueId\": \"$PARAM_UNIQUE_ID\",  \"availableReplicas\": 1,\"createdReplicas\": 1, \"desiredReplicas\": 1, \"readyReplicas\": 1,\"tags\": [\"app:$PARAM_TAG_APP\",\"namespace:$DATA_NAMESPACE\"],\"vertexType\": \"resource\" "

    curl -X DELETE --insecure -u $NOI_REST_USR:$NOI_REST_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: $TENENT_ID"  --header "JobId: $JOB_ID" -d "{$JSON_DATA}" "$URL_PREFIX/resources"

}


## method
deleteLink() {
    FROM_ID=$1
    TO_ID=$2
    CONNECT_TYPE=$3

    curl -X DELETE --insecure -u $NOI_REST_USR:$NOI_REST_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: ${TENENT_ID}" -d "{}" "$URL_PREFIX/resources/$FROM_ID/references/out/$CONNECT_TYPE/$TO_ID"
}

deleteLink_DependsOn() {
    FROM_ID=$1
    TO_ID=$2
    LINK_TYPE=$3

    echo "$FROM_ID ----> $TO_ID"
    deleteLink $FROM_ID $TO_ID $LINK_TYPE
}

createLink_DependsOn() {
    FROM_ID=$1
    TO_ID=$2

    echo "$FROM_ID ----> $TO_ID"
    createLink $FROM_ID $TO_ID 'DependsOn'
}

createLink_DependsOn_DeploymentPodService() {
    ENTITY_NAME_PREFIX=$1

    ENTITY_DEPLOYMENT=${ENTITY_NAME_PREFIX}_ID_DEPLOYMENT
    ENTITY_POD=${ENTITY_NAME_PREFIX}_ID_POD
    ENTITY_SVC=${ENTITY_NAME_PREFIX}_ID_SVC

    createLink_DependsOn ${!ENTITY_DEPLOYMENT} ${!ENTITY_POD} 'DependsOn'
    createLink_DependsOn ${!ENTITY_SVC} ${!ENTITY_POD} 'DependsOn'
}

deleteDeploymentPodService() {
    MICRO_SERVICE_NAME=$1

    echo "Node creation for : $MICRO_SERVICE_NAME"
    deleteNode "deployment" "$MICRO_SERVICE_NAME-deployment" "$MICRO_SERVICE_NAME-deployment" "$MICRO_SERVICE_NAME-deployment-id" "ilender"
    deleteNode "pod" "$MICRO_SERVICE_NAME-pod" "$MICRO_SERVICE_NAME-pod" "$MICRO_SERVICE_NAME-pod-id" "ilender"
    deleteNode "service" "$MICRO_SERVICE_NAME-svc" "$MICRO_SERVICE_NAME-svc" "$MICRO_SERVICE_NAME-svc-id" "ilender"
}


## method
updateMatchToken() {
    UNIQUE_ID=$1
    ID=$2

    JSON_DATA="{ \"matchTokens\": [\"$UNIQUE_ID\", \"$ID\"]}"
    echo "JSON_DATA : $JSON_DATA"

    curl -X POST --insecure -u $NOI_REST_USR:$NOI_REST_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: ${TENENT_ID}" -d "$JSON_DATA" "$URL_PREFIX/resources/$ID"
}