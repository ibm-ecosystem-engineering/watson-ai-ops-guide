# Getting Cluster Access Token and encrypting for ASM toplogy observer job 

Document explains about 

- How to get Cluster Access Token
- How to encrypt the cluster token to use itin ASM toplogy observer job


## 1. Retrive Cluster Access token of the target cluster

### Login to the OCP / Kubernetes cluster.

Login into the OCP cluster where you want to get the access token

```
oc login --token=YYYYYYYYYYYYYYYYYY --server=https://Zzzzzzzzzz:11111
```

### Create Service Account

Create Service account by using the given sample yaml [Sample yaml](files/service-account.yaml) 

```
oc apply -f ./files/service-account.yaml
```

###  Get the Token

Run the below command by replacing << SERVICE_ACCOUNT_NAME >>

```
TOKEN=$(kubectl get secrets -o jsonpath="{.items[?(@.metadata.annotations['kubernetes\.io/service-account\.name']=='<< SERVICE_ACCOUNT_NAME >>')].data.token}"|base64 --decode)
```

ex: 

```
kubectl config set-context --current --namespace=bookinfo

TOKEN=$(kubectl get secrets -o jsonpath="{.items[?(@.metadata.annotations['kubernetes\.io/service-account\.name']=='bookinfo-service-account')].data.token}"|base64 --decode)
```

You might have got the token to access to your cluster from curl. You can print the token and check.

```
echo $TOKEN
```

###  Verify the Token (Optional)

Verify the token by accessing the cluster using API.

1. Export the cluster name

Export the cluster name and id like the below. You need to replace the << CLUSTER_NAME >> and << CLUSTER ID >>

```
export CLUSTER_NAME="<< CLUSTER_NAME >> / << CLUSTER ID >>"
```

Ex:

```
export CLUSTER_NAME="mycluster-aiops/bvqsvmod0125spct9av0"
```

2. Get the API Server

Run the below command as it is

```
APISERVER=$(kubectl config view -o jsonpath="{.clusters[?(@.name==\"$CLUSTER_NAME\")].cluster.server}")
```

3. Verify your access 

Run the below command and see if you can get the list of nodes from your cluster.

```
curl -X GET $APISERVER/api/v1/nodes --header "Authorization: Bearer $TOKEN" --insecure
```

Easy to refer example :

```
curl -X GET https://c111-e.us-south.containers.cloud.ibm.com:11111/api/v1/nodes --header "Authorization: Bearer $TOKEN" --insecure

```

## 2. Encrypt the token using topology-topology pod

Encrypt the token using the topology-topology pod.

### Login to the OCP (Watson AI-Ops Installed cluster)

Login into the OCP cluster 

```
oc login --token=YYYYYYYYYYYYYYYYYY --server=https://Zzzzzzzzzz:11111
```

### Login to the OCP (Watson AI-Ops Installed cluster)

1. Get inside the namespace where ai-ops installed.

ex:

```
 oc project aiops21
```

2. Get into the pod `topology-topology`

```
 oc exec -it $(oc get po |grep topology-topology|awk '{print $1}') bash
```

3. Encrypt the token

Run the below command by replacing the << TOKEN >> with the target cluster access token we retieved in the above stop. 

```
 java -jar /opt/ibm/topology-service/topology-service.jar encrypt_password --password '<< TOKEN >>'
```

OR

```
 oc exec -ti <xxxxxxxxx>-topology-topology-<xxxxxxxxx-xxxxx> -- java -jar /opt/ibm/topology-service/topology-service.jar encrypt_password -p '<< TOKEN >>' > <encrypted_sa_token.txt>
```


## Notes and Reference 

This document is useful when you are configuring observer job in ASM 
[here](../400-topology-observer-job-config) . 
