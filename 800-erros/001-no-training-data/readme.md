# No training data found !!! Please check elastic index and data-prep logs


## Tags

Log Anomaly Training, Humio


## Problem

Log anomaly training is done using the below command.

```
python3 train_pipeline.pyc -p "log" -g "w0vpv1gi" -a "za4xk6hg" -v "1"
```

During the training got the below error.


```
Launching Jobs for: Log Ingest Training
	prepare training environment

	training_ids:
		1: ['training-7Ozu2aLGR']
	jobs ids are saved here: JOBS/w0vpv1gi/za4xk6hg/1/log_ingest.json


	Training... |████████████████████████████████| [0:03:20], complete: 1/1 {'COMPLETED': 1}

	Job-ids ['training-7Ozu2aLGR'] are COMPLETED
	Please check the logs of COMPLETED jobs here: s3://log-anomaly



Launching Jobs for: Log Anomaly Training
	prepare training environment
No training data found !!! Please check elastic index and data-prep logs

```

## Problem Analysis

The mapping json should be available in the trainer pod for all type of logs execept LogDNA (as it is default log format).

For traning the humio logs are used here. So the mapping file for humio should exists in the trainer pod.

## Solution

Create a humio mapping json and copy to the training pod.

#### Create Mapping Json

Create a file named `w0vpv1gi-za4xk6hg-ingest_conf.json` with the below json content.

w0vpv1gi - Application Group Id

za4xk6hg - Application Id 


```
{
  "mapping": {
    "codec": "humio",
    "rolling_time": 10,
    "instance_id_field": "kubernetes.container_name",
    "log_entity_types": "kubernetes.namespace_name,kubernetes.container_hash,kubernetes.host,kubernetes.container_name,kubernetes.pod_name",
    "message_field": "@rawstring",
    "timestamp_field": "@timestamp"
  }
}
```

#### Copy mapping Json into trianer pod.

Copy the file into `/home/zeno/train/ingest_configs/log` folder using the below command.

```
oc cp w0vpv1gi-za4xk6hg-ingest_conf.json $(oc get po |grep model-train-console|awk '{print $1}'):/home/zeno/train/ingest_configs/log
```




