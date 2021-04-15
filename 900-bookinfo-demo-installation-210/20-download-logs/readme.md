# Downloading Logs

## 1 Humio Logs

1. Download the logs using the link 

 [../../710-configuring-humio](../../710-configuring-humio)

 Section : 4. Download Logs from Humio

2. Copy the downloaded logs file to `/training-files/1/logs.json`

3. Run the below command to see, how much lines of log the file contains.

```bash

cd training-files/1

sed 's/kubernetes.labels.app/kubernetes_labels_app/g' logs.json | jq ."kubernetes_labels_app" | sort | uniq -c
```

It may give results like this

```
12000 "details"
114000 "productpage"
6000 "ratings"
12000 "reviews"
```

Here each service should contain more than `2000` records.

## 2 LogDNA Logs

1. Download the logs using the link

[../../700-configuring-logdna](../../700-configuring-logdna)

Section : 5. Download Logs from LogDNA using Script

2. Copy the downloaded logs file to `/training-files/1/logs.json`

3. Run the below command to see, how much lines of log the file contains.

```bash

cd training-files/1

cat logs.json | jq ."_app" | sort | uniq -c

```

It may give results like this

```
$ cat myLog.json | jq ."_app" | sort | uniq -c
7492 "details"
71174 "productpage"
3746 "ratings"
7492 "reviews"
```

Here each service should contain more than `2000` records.

