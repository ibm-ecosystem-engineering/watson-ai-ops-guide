# Training Logs


1. Download the logs file and copy to `/training-files/1/humio-logs.json`

2. Run the below command to see, how much lings of log the file contains.

```bash

cd training-files/1

sed 's/kubernetes.labels.app/kubernetes_labels_app/g' humio-logs.json | jq ."kubernetes_labels_app" | sort | uniq -c

12000 "details"
114000 "productpage"
6000 "ratings"
12000 "reviews"

```

Here each service contains more that 2000 records and it is good to for training.

2. Update the parameters in the `/scripts/00-config.sh`

3. Run the file `/scripts/01-logs-training.sh`

it may print like this. you can execute the command one by one.

```bash
........................................................................
oc exec -it aimanager-aio-model-train-console-86337d34444-z4br4 bash
aws s3 mb s3://log-ingest
aws s3 cp /home/zeno/data/log-ingest/  s3://log-ingest/ --recursive
..........
based on the log type, you can run any one of the below
cp /home/zeno/train/ingest_configs/log/groupid-appid-ingest_conf.json.humio_example /home/zeno/train/ingest_configs/log/opvkblbd-9p1o48rs-ingest_conf.json
cp /home/zeno/train/ingest_configs/log/groupid-appid-ingest_conf.json.elk_example /home/zeno/train/ingest_configs/log/opvkblbd-9p1o48rs-ingest_conf.json
cp /home/zeno/train/ingest_configs/log/groupid-appid-ingest_conf.json.splunk_example /home/zeno/train/ingest_configs/log/opvkblbd-9p1o48rs-ingest_conf.json
..........
cd /home/zeno/train
python3 train_pipeline.pyc -p "log" -g "abcdefgh" -a "8a2z45ds" -v "1"
........................................................................

```

