# Training Events

1. Update the parameters in the `/scripts/00-config.sh`

2. Run the file `/scripts/01-events-training.sh`

it may print like this. you can execute the command one by one.

```bash
........................................................................
oc exec -it aimanager-aio-model-train-console-79469f976b-z4br4 bash
aws s3 mb s3://event-ingest
aws s3 cp /home/zeno/data/event-ingest/  s3://event-ingest/ --recursive
..........
cd /home/zeno/train
python3 train_pipeline.pyc -p "event" -g "abcdefgh" -a "8a2z45ds" -v "1"
........................................................................

```

