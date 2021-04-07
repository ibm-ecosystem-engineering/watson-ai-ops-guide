#!/bin/sh

echo "Similar Incidents started ..... $(date)"

source ./00-config.sh

echo "........................................."
echo " Here are the parameters used in the script ... hope you have already done 'oc login ...' "
echo "     Namespace : $NAMESAPCE"
echo "     ApplicationGroupId : $APPLICATION_GROUP_ID"
echo "     ApplicationId : $APPLICATION_ID"
echo "     Training file  : $TRAINING_FILE"
echo "........................................."
echo ""
echo ""

##  Switch namesapce
oc project $NAMESAPCE

#### create folder struture in training pod
oc exec -it $(oc get po |grep model-train-console|awk '{print$1}') -- /bin/sh -c "mkdir -p /home/zeno/data/incident-ingest/$APPLICATION_GROUP_ID/$APPLICATION_ID"

####  copy training file to training pod
oc cp $TRAINING_FILE $(oc get po |grep model-train-console|awk '{print $1}'):/home/zeno/data/incident-ingest/$APPLICATION_GROUP_ID/$APPLICATION_ID/incidents.json

echo "Files copied to training pod. "

echo "You can run the below commands from terminal"
echo "........................................................................"
echo "oc exec -it $(oc get po |grep model-train-console|awk '{print$1}') bash"
echo "aws s3 mb s3://similar-incident-service"
echo "aws s3 cp /home/zeno/data/incident-ingest/  s3://similar-incident-service/ --recursive"
echo ".........."
echo "cp /home/zeno/train/deploy_model.pyc /home/zeno/train/deploy_model.py"
echo "cd /home/zeno/incident"
echo "bash index_incidents.sh s3://similar-incident-service/$APPLICATION_GROUP_ID/$APPLICATION_ID/incidents.json $APPLICATION_GROUP_ID $APPLICATION_ID "
echo "........................................................................"

echo "Similar Incidents Training completed ..... $(date)"
