# Training Logs

## 1. Copy the Download logs

Copy the Download logs from logDNA/Humio to `/training-files/1/logs.json`

## 2. Update Config.sh

Update the parameters in `/scripts/00-config.sh`

## 3. Start Training

1. Run the file `/scripts/01-logs-training.sh`

it may print like this. 


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

2. Run the above commands one by one
