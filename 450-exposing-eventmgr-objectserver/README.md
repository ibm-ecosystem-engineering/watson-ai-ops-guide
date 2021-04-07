# Exposing an ObjectServer in Event Manager

This document helps to expose the ObjectServer of the Event Manager outside cluster, which helps to push events to event manager through CURL.

The article is based on the the following

- RedHat OpenShift 4.5 on IBM Cloud (ROKS)
- Watson AI-Ops 2.1

## Overview

#### 1. Login to the OCP

Login into the OCP cluster where you have the NOI (Event manager is installed)

#### 2. Edit configmap 

2.1 Edit the configmap suffixed with `objserv-agg-primary-config`

```bash
oc edit configmap noi-objserv-agg-primary-config
```

2.1 Update the below property.

```bash
data:
  agg-p-props-append: |
    NRestOS.Enable: TRUE
    NHttpd.EnableHTTP: TRUE
    NHttpd.ListeningPort: 8080
```

#### 3. Recreate pod 

Delete the pod suffixed with `ncoprimary-0`, to reflect the configmap changes.

```bash
oc get pod | grep ncoprimary-0

oc delete pod noi-ncoprimary-0
```

#### 4. Create Service

Expose the above pod (after it is recreated) and create a service called `objserver-nodeport`

```bash
oc expose po noi-ncoprimary-0 --port=8080 --type=NodePort --name=objserver-nodeport
```

#### 5. Create Route

Expose the above service and create route called `objectserver-route`

```bash
oc expose service objserver-nodeport --name=objectserver-route --port=8080
```

#### 6. Retrieve host path

Get the host path from the above created route.

```bash
oc get route objectserver-route -o yaml
```

It may be like this `aiops-abcd.appdomain.cloud`

By framing the url like the below, we can push the events to eventmanger

`http://objectserver-route-aiops-abcd.appdomain.cloud/objectserver/restapi/alerts/status`


#### 7. Retrieve Password

To push events, we need password along with the above url.

Get the password from the secret ends with `omni-secret`

```bash
oc get secret noi-omni-secret -o yaml
```

You need to decrypt the password like this.

```bash
echo "asdfasdfsadfasdfsd" | base64 -d
```

The output could be `pMl4XUx3TsIFAbC`


## Pushing Events to EventManagr using Curl

You can push events like the below.

```bash
curl -X POST -v -u root:pMl4XUx3TsIFAbC -H "Accept: application/json" -H "Content-Type: application/json" -d @ratings_pod_down.json http://objectserver-route-aiops-abcd.appdomain.cloud/objectserver/restapi/alerts/status
```

The `ratings_pod_down.json` down file is avilable [here](./files/ratings_pod_down.json) , which you can copy to the current folder where you run the above script.


## Reference

Exposing an ObjectServer port in a Netcool® Operations Insight on Red Hat® OpenShift® deployment
https://www.ibm.com/support/knowledgecenter/SSTPTP_1.6.3/com.ibm.netcool_ops.doc/soc/integration/task/expose_objs_port.html