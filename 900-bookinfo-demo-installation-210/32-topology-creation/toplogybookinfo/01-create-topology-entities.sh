#!/usr/bin/env bash

source ./00-config.sh
source ./00-process.sh

createDeploymentPodService "$SERVICE_PRODUCT_PAGE" 
createDeploymentPodService "$SERVICE_REVIEWS_V1"
createDeploymentPodService "$SERVICE_REVIEWS_V2"
createDeploymentPodService "$SERVICE_REVIEWS_V3"
createDeploymentPodService "$SERVICE_DETAILS"
createDeploymentPodService "$SERVICE_RATINGS"
