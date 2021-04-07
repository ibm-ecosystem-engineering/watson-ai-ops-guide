# Getting Cluster Access Token

Document explains about how create Cluster Access Token to login into OCP / kubernetes

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

Run the below command 

```

oc project my-access-ns

or 

kubectl config current-context
kubectl config set-context --current --namespace=my-access-ns


TOKEN=$(kubectl get secrets -n my-access-ns -o jsonpath="{.items[?(@.metadata.annotations['kubernetes\.io/service-account\.name']=='my-access-service-account')].data.token}"|base64 --decode)
```

You might have got the token to access to your cluster from curl. You can print the token and check.

```
echo $TOKEN
```

if `kubectl get secrets -n my-access-ns` gives you two secrets with the name `my-access-service-account-token` then get token manually using the ocp console.

### Login into OCP

Run the below command to login into OCP.

```
oc login --token=$TOKEN --server=$APISERVER

```

Ex:

```
oc login --token=eyJhbGciOiJSUzI1NiIsImtpZCIH_xfuSv9r2BvMAsD4-mQ --server=https://c111-e.us-south.containers.cloud.ibm.com:11111
```