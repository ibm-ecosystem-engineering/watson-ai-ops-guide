# Training Similar Incidents

## 1. Update Config.sh

Update the parameters in `/scripts/00-config.sh`

## 2. Start Training

1. Run the file `/scripts/01-incidents-training.sh`

it may print like this. 

```bash
........................................................................
oc exec -it aimanager-aio-model-train-console-sadfsfas-sdfsf bash
aws s3 mb s3://similar-incident-service
aws s3 cp /home/zeno/data/incident-ingest/  s3://similar-incident-service/ --recursive
..........
cp /home/zeno/train/deploy_model.pyc /home/zeno/train/deploy_model.py
cd /home/zeno/incident
bash index_incidents.sh s3://similar-incident-service/abcdefgh/8a2z45ds/incidents.json abcdefgh 8a2z45ds
........................................................................

```

2. Run the above commands one by one.
