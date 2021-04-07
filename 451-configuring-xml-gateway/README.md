# Configuring XML Gateway in Event Manager

This document explains about how to configure XML Gateway to send events from event manager to AI-Manager.

The article is based on the the following

- RedHat OpenShift 4.5 on IBM Cloud (ROKS)
- Watson AI-Ops 2.1


## Overview

It is required to create two kubernetes resoures for deploying xml gateway.

- Deployment
- Configmap

The sample yaml files are available here.

- [noi-gateway-configmap.yaml](./files/noi-gateway-configmap.yaml)
- [noi-gateway-deployment.yaml](./files/noi-gateway-deployment.yaml)


## Get NOI name

Find and name of the NOI instance, which has to be prefixed with many other resources below.

```
oc get NOI
```

Most probably the value would be `noi`. Lets use this name further by default.

 
## 1. Update Deployment

The `noi-gateway-deployment.yaml` will be updated in the below steps.

#### 1.1 Update Namespace

Replace `NAMESPACE_VALUEEEEEE` in yaml with your namespace value. 

```
namespace: NAMESPACE_VALUEEEEEE
```


#### 1.2 Update serviceAccountName

Get the serviceaccount ends with `-service-account`

```
oc get serviceaccount | grep -service-account
```

Most probably the value would be `noi-service-account` (if you have used `noi`as NOI name)

Replace `SERVICE_ACCOUNT_VALUEEEEEE` in yaml with above found value. 

```
serviceAccountName: SERVICE_ACCOUNT_VALUEEEEEE
```

#### 1.3 Update imagePullSecrets

Replace `IMAGE_PULL_SECRETS_VALUEEEEEE` in yaml with the docker registry secret that you have created for NOI (ex: cp.icr.io).


```
      imagePullSecrets:
        - name: IMAGE_PULL_SECRETS_VALUEEEEEE
```

## 2. Update ConfigMap

The `noi-gateway-configmap.yaml` will be updated in the below steps.

#### 2.1 Update Namespace

Replace `NAMESPACE_VALUEEEEEE` in yaml with your namespace value. 

```
namespace: NAMESPACE_VALUEEEEEE
```

#### 2.1 Update Primary and Backup


1. Run the below command 

```
    oc get svc | grep objserv | grep Cluster
```

You may get the below results

```
    noi-objserv-agg-backup                                           ClusterIP   172.21.181.191   <none>        4100/TCP,4300/TCP                                       26h
    noi-objserv-agg-primary                                          ClusterIP   172.21.46.121    <none>        4100/TCP                                                26h
    noi-topology-objserv-backup                                      ClusterIP   172.21.205.174   <none>        4100/TCP                                                26h
    noi-topology-objserv-primary                                     ClusterIP   172.21.116.35    <none>        4100/TCP                                                26h
```
  
2. Replace `PRIMARY_VALUEEEEEE` in yaml with `noi-objserv-agg-primary` from above output. (more than one occurances)

3. Replace `BACKUP_VALUEEEEEE` in yaml with `noi-objserv-agg-backup` from above output. (more than one occurances)


#### 2.2 Update topics

Replace appropriate noi integration kafka topics of AI-Manager (ex: alerts-noi-bvqabmfy-xnklqawz) into `TOPICS_VALUEEEEEE` in the yaml.

```
"topics": "TOPICS_VALUEEEEEE"
```

#### 2.3 Update brokers

Run the below command

```
oc get routes strimzi-cluster-kafka-bootstrap -o=jsonpath='{.status.ingress[0].host}{"\n"}'
```

You may get output like this. iI you don't get any output, refer [Expose Strimzi Kafka Brokers](../420-accessing-kafka-topics)


```
strimzi-cluster-kafka-bootstrap-aiops-abcd.appdomain.cloud
```

Replace the above output into `BROKER_VALUEEEEEE` in the yaml. Don't replace 443.

```
"brokers" : "BROKER_VALUEEEEEE:443"
```

#### 2.4 Update Passwords

Run the below command

```
oc get secret token --template={{.data.password}} | base64 --decode
```

You may get output like this `AB0XB1AIz71L`

Replace the above output into `PASSWORD_VALUEEEEEE` in the yaml under `kafka_client_jaas.conf`

```
     password="PASSWORD_VALUEEEEEE"
```


#### 2.5 Update Filters

Update the filters appropriately. 

As per the below filter, `Manager = 'CEM'` is expected in the event json. Only then the events would be pushed to AI-Manager kafka topic.

```
  row_filter.def: |-
    REPLICATE INSERT FROM TABLE 'alerts.status'
    USING MAP 'StatusMap'
    FILTER WITH 'Type IN (1, 13, 20) AND Class != 99999 AND Manager = \'CEM\'';
```

Sample event file is available [here](./files/ratings_pod_down.json)


## 3 Deploy the yamls

Do `oc apply` to the yaml files.

```
oc apply -f ./files/noi-gateway-configmap.yaml

oc apply -f ./files/noi-gateway-deployment.yaml
```


## References

Create AIOPS EventManager Gateway
https://pages.github.ibm.com/up-and-running/watson-aiops/Event_Manager/Create_AIOPS_EventManager_Gateway/

Configuring a gateway between Watson AIOps and Event Manager
https://www.ibm.com/docs/en/cloud-paks/cp-data/3.0.1?topic=aiops-configuring-gateway-between-watson-event-manager