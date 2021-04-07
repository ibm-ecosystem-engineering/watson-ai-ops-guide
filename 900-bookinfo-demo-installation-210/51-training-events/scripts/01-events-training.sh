#!/bin/sh

echo "Events Training started ..... $(date)"

source ./00-config.sh

echo "........................................."
echo " Here are the parameters used in the script ... hope you have already done 'oc login ...' "
echo "     Namespace : $NAMESAPCE"
echo "     ApplicationGroupId : $APPLICATION_GROUP_ID"
echo "     ApplicationId : $APPLICATION_ID"
echo "     Training Version : $TRAINING_VERSION"
echo "     Training files folder : $TRAINING_FILES_FOLDER"
echo "........................................."
echo ""
echo ""

##  Switch namesapce
oc project $NAMESAPCE

#### create folder struture in training pod
oc exec -it $(oc get po |grep model-train-console|awk '{print$1}') -- /bin/sh -c "mkdir -p /home/zeno/data/event-ingest/$APPLICATION_GROUP_ID/$APPLICATION_ID"

#### copy mapping file in training pod
oc exec -it $(oc get po |grep model-train-console|awk '{print$1}') -- /bin/sh -c "cp /home/zeno/train/ingest_configs/event/groupid-appid-ingest_conf.json.example /home/zeno/train/ingest_configs/event/$APP_GROUP_ID-$APP_ID-ingest_conf.json"

####  copy training files to training pod
oc cp $TRAINING_FILES_FOLDER $(oc get po |grep model-train-console|awk '{print $1}'):/home/zeno/data/event-ingest/$APPLICATION_GROUP_ID/$APPLICATION_ID

echo "Files copied to training pod. "

echo "You can run the below commands from terminal"
echo "........................................................................"
echo "oc exec -it $(oc get po |grep model-train-console|awk '{print$1}') bash"
echo "aws s3 mb s3://event-ingest"
echo "aws s3 cp /home/zeno/data/event-ingest/  s3://event-ingest/ --recursive"
echo ".........."
echo "cd /home/zeno/train"
echo "python3 train_pipeline.pyc -p \"event\" -g \"$APPLICATION_GROUP_ID\" -a \"$APPLICATION_ID\" -v \"$TRAINING_VERSION\" "
echo "........................................................................"

echo "Events Training completed ..... $(date)"
