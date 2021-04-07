# No training data found !!! Please check elastic index and data-prep logs

## Tags

Log Anomaly Training, s3_datastore, mount_cos

## Problem

Log anomaly training is done using the below command.

```
python3 train_pipeline.pyc -p "log" -g "w0vpv1gi" -a "za4xk6hg" -v "1"
```

During the training got the below error.


```
<user1>$ python3 train_pipeline.pyc -p "log" -g "asdfadsf" -a "adfssadf" -v "1"
Traceback (most recent call last):
  File "/home/zeno/train/train_pipeline.py", line 31, in <module>
ValueError: source code string cannot contain null bytes

```

## Problem Analysis

Training pod probelm

## Solution

1. Restart the Training pod

```
oc exec -it $(oc get po |grep model-train-console|awk '{print$1}') bash

oc delete pod xxxxxx
```

2. Change the s3_datastore

3. Start the training again.