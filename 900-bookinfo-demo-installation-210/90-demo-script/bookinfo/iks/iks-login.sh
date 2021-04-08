#!/bin/bash

echo "iks-login started ..... $(date)"

source ./config.sh

## IBM Cloud API Key
ibmcloud login --apikey $IBMCLOUD_API_KEY

## Cluster Id
ibmcloud ks cluster config --cluster $IKS_CLUSTER_ID

kubectl config current-context

## bookinfo namespace
kubectl config set-context --current --namespace=$NAMESAPCE_APP

echo "iks-login completed ..... $(date)"
