# Downloading Logs

## 1 Humio Logs

1. Download the logs using the link [../../710-configuring-humio](../../710-configuring-humio)

Section : 4. Download Logs from Humio

2. Copy the downloaded logs file to `/training-files/1/logs.json`

2. Run the below command to see, how much lings of log the file contains.

```bash

cd training-files/1

sed 's/kubernetes.labels.app/kubernetes_labels_app/g' logs.json | jq ."kubernetes_labels_app" | sort | uniq -c

12000 "details"
114000 "productpage"
6000 "ratings"
12000 "reviews"
```

Here each service contains more that 2000 records and it is good to for training.

## 2 LogDNA Logs

1. Download the logs using the link [../../700-configuring-logdna](../../700-configuring-logdna)

Section : 5. Download Logs from LogDNA using Script
