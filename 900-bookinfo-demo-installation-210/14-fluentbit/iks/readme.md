# Installing FluentBit in IKS

The FluentBit can be downloaded using the info from the url.

https://docs.humio.com/docs/ingesting-data/log-formats/kubernetes/

We have downloaded the same and available in the folder `humio-helm-charts`

You can also refer  [here](../../../720-configuring-fluentbit),


## 1. Update Override.yaml

1. Update the feld `humioHostname`

2. Update the field `humioRepoName` and `port` if required.

## 2. Update values.yaml

The `/humio-helm-charts/charts/humio-fluentbit/values.yaml` should be updated as given below.

`Path` under the section `[INPUT]`. The below config allows only the logs from bookinfo namespace to push to humio

```
        Path             /var/log/containers/*bookinfo*.log
```

## 3. Install fluentbit

#### 1. Create Namesapce

create a namespace called `fluentbit-bk` and get into the same namespace.

```
kubectl create ns fluentbit-bk
kubectl config set-context --current --namespace=fluentbit-bk
```

#### 2. Helm Install fluentbit

Run the below command after replacing the TOKEN_VALUEEE with the humion ingest token.

```
helm install humio-bookinfo-fluentbit ./humio-helm-charts --namespace fluentbit-bk --set humio-fluentbit.token=TOKEN_VALUEEE --values ./override.yaml
```

#### 2. UnInstall fluentbit

To delete the fluentbit, run the below command.

```
helm delete humio-bookinfo-fluentbit
```


