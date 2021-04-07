# DLaaS (Deep Learning as a Service)

DLaaS helps to cleanup if any error occured during the logs training.

## Training POD

DLaaS commands to be run inside the training POD.

Here is the command to get into the training pod.

```
 oc exec -it $(oc get po |grep model-train-console|awk '{print $1}') bash
```

## dlaas ls

This command lists all trainings done so far.

```
<user1>$ dlaas ls
```

The output could be like the below.

```
ID                 NAME        FRAMEWORKS                    STATUS    START                         COMPLETED 
training--J3iZj1Gg Log Ingest  data-preprocessing-mtworkflow           2020-12-18 07:08:05 +0000 UTC 2020-12-18 07:11:12 +0000 UTC
training-yD3OZjJGR Log Anomaly log-anomaly-training                    2020-12-18 07:12:27 +0000 UTC 2020-12-18 07:14:58 +0000 UTC
training-hwqOZC1GR Log Anomaly log-anomaly-training                    2020-12-18 07:12:28 +0000 UTC 2020-12-18 07:17:15 +0000 UTC
training-DkeOWCJMR Log Anomaly log-anomaly-training                    2020-12-18 07:12:28 +0000 UTC 2020-12-18 07:20:03 +0000 UTC
training-U3cbGK-Mg Log Ingest  data-preprocessing-mtworkflow           2021-01-05 04:19:04 +0000 UTC 2021-01-05 04:22:13 +0000 UTC
training-oQ5lGF-MR Log Anomaly log-anomaly-training                    2021-01-05 04:23:26 +0000 UTC 2021-01-05 04:26:12 +0000 UTC
training-97tlMKaGg Log Anomaly log-anomaly-training                    2021-01-05 04:23:27 +0000 UTC 2021-01-05 04:27:37 +0000 UTC
```

## dlaas delete

This command delete the mentioned trainings.

```
dlaas delete training-obRpLKaGg training-ZmzpYK-Mg
```

## Reference

Getting Started with Deep Learning as a Service (DLaaS) on the IBM Cloud

https://medium.com/@utk.is.here/getting-started-with-deep-learning-as-service-dlaas-on-the-ibm-cloud-c1c081bc4008
