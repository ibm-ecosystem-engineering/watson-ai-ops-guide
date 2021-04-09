# moving trained models : error copying files log-model

## Tags

Log Anomaly Training, Humio, 

## Problem

Log anomaly training is done using the below command.

```
python3 train_pipeline.pyc -p "log" -g "w0vpv1gi" -a "za4xk6hg" -v "2"
```

During the training got the below error.

```
Launching Jobs for: Log Ingest Training
	prepare training environment

	training_ids:
		1: ['training-GCFhXaLMR']
	jobs ids are saved here: JOBS/w0vpv1gi/za4xk6hg/2/log_ingest.json


	Training... |████████████████████████████████| [0:03:20], complete: 1/1 {'COMPLETED': 1}

	Job-ids ['training-GCFhXaLMR'] are COMPLETED
	Please check the logs of COMPLETED jobs here: s3://log-anomaly


Launching Jobs for: Log Anomaly Training
	prepare training environment

	training_ids:
		1: container-financialplan --> ['training-21Afu-YGR']
		2: container-web --> ['training-1_ABu-LMg']
		3: container-user --> ['training-aVJfuaYGR']
	jobs ids are saved here: JOBS/w0vpv1gi/za4xk6hg/2/log_anomaly.json


	Training... |████████████████████████████████| [0:03:20], complete: 3/3 {'COMPLETED': 3}

	Job-ids ['training-21Afu-YGR', 'training-1_ABu-LMg', 'training-aVJfuaYGR'] are COMPLETED
	Please check the logs of COMPLETED jobs here: s3://log-model

	moving trained models
		log-model/training-21Afu-YGR/w0vpv1gi/za4xk6hg --> log-model/w0vpv1gi/za4xk6hg
	error copying files log-model/training-21Afu-YGR/w0vpv1gi/za4xk6hg --> log-model/w0vpv1gi/za4xk6hg


```

## Problem Analysis

This error is due to the less amount of data in the logs used for the training.  

The training is completed successfully. But it failed only during the copying the files.

The log files used for the training is available here. [ Log file for training ](files/normal-2.json)  


## Solution

By running the `deploy_model.pyc` you can copy the files again.


1. Goto the folder 

```
cd /home/zeno/train
```

2. Initiate the copy again by running the below command.

```
python3 deploy_model.pyc -p "log" -g "w0vpv1gi" -a "za4xk6hg" -v "2"
```

Replace the app-group-id, app-id and version accordingly.
