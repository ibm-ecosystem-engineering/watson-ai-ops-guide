#!/bin/bash

H_ACCEEPT="Accept: application/json"
H_CONTENT="Content-Type: application/json"

EVENT_PASSWORD=
URL_EVENT_MGR=http://objectserver-route-aiops.abcd.appdomain.cloud/objectserver/restapi/alerts/status

### AI-Ops env
NAMESAPCE=aiops
APPLICATION_GROUP_ID=opvkblbd
APPLICATION_ID=9p1o48rs

### AI-Ops OCP env
OCP_TOKEN=""
OCP_SERVER="https://c222-e.us-south.containers.cloud.ibm.com:33333"

### IKS (Managed env)
IBMCLOUD_API_KEY=
IKS_CLUSTER_ID=csadfdasd0ohsnstmnnqg
NAMESAPCE_APP=bookinfo
APP_URL=http://1.1.1.1:31010/productpage?u=normal

