#!/bin/sh

echo "Logs Training started ..... $(date)"

source ./00-config.sh

echo "........................................."
echo " Here are the parameters used in the script ... hope you have already done 'oc login ...' "
echo "     Namespace : $NAMESAPCE"
echo "     ApplicationGroupId : $APPLICATION_GROUP_ID"
echo "     ApplicationId : $APPLICATION_ID"
echo "     Training Version : $TRAINING_VERSION"
echo "     Traning file : $TRAINING_FILE"
echo "........................................."
echo ""
echo ""

##  Switch namesapce
oc project $NAMESAPCE

##  Create temp folder and go inside
rm -rfd temp-gan
mkdir temp-gan
cd temp-gan

##  Create version folder
mkdir $TRAINING_VERSION
cd $TRAINING_VERSION

##  copy the training log file
cp -r $TRAINING_FILE .

##  gzip the training log file
gzip *.json
mv *.gz normal-$TRAINING_VERSION.json.gz
cd ../

####  create folders in training pod
oc exec -it $(oc get po |grep model-train-console|awk '{print$1}') -- /bin/sh -c "mkdir -p /home/zeno/data/log-ingest/$APPLICATION_GROUP_ID/$APPLICATION_ID"

####  copy the files to training pod
oc cp $TRAINING_VERSION $(oc get po |grep model-train-console|awk '{print $1}'):/home/zeno/data/log-ingest/$APPLICATION_GROUP_ID/$APPLICATION_ID

##  Create temp folder and go inside
rm -rfd temp-gan

echo "You can run the below commands from terminal"
echo "........................................................................"
echo "oc exec -it $(oc get po |grep model-train-console|awk '{print$1}') bash"
echo "aws s3 mb s3://log-ingest"
echo "aws s3 cp /home/zeno/data/log-ingest/  s3://log-ingest/ --recursive"
echo ".........."
echo "based on the log type, you can run any one of the below"
echo "cp /home/zeno/train/ingest_configs/log/groupid-appid-ingest_conf.json.humio_example /home/zeno/train/ingest_configs/log/$APPLICATION_GROUP_ID-$APPLICATION_ID-ingest_conf.json"
echo "cp /home/zeno/train/ingest_configs/log/groupid-appid-ingest_conf.json.elk_example /home/zeno/train/ingest_configs/log/$APPLICATION_GROUP_ID-$APPLICATION_ID-ingest_conf.json"
echo "cp /home/zeno/train/ingest_configs/log/groupid-appid-ingest_conf.json.splunk_example /home/zeno/train/ingest_configs/log/$APPLICATION_GROUP_ID-$APPLICATION_ID-ingest_conf.json"
echo ".........."
echo "cd /home/zeno/train"
echo "python3 train_pipeline.pyc -p \"log\" -g \"$APPLICATION_GROUP_ID\" -a \"$APPLICATION_ID\" -v \"$TRAINING_VERSION\" "
echo "........................................................................"

echo "Logs Training completed ..... $(date)"
