# Demo Script

## Update config.sh

#### 1. OCP Server

Update `OCP_SERVER`

#### 2. OCP Token

Update the permanent OCP token by doing below.

1. Change the namespaces in the file  `files/token.yaml` to your AI-Ops namespace.

2. Deploy the yaml file

 ```
 oc apply -f ./files/token.yaml
 ```

3. Get the list of secrets

 ```
oc get secrets runbook-service-account -n aiops
 ```

4. Get the secrets as yaml

```
oc get secrets runbook-service-account-????????? -n aiops -o yaml
```

5. Decode the secret like the below

```
echo "AAAAAAAA" |base64 --decode
```

6. Put the values in the property 

```
OCP_TOKEN=""
```

#### 3. IBM Cloud API Key

1. Create IBM Cloud API Key for accessing IKS Cluster using the link [../../602-accessing-iks-cluster-using-api-key](../../602-accessing-iks-cluster-using-api-keys) 

2. Update the below property.

```
IBMCLOUD_API_KEY=
```

#### 4. IKS Cluster Id

Update the iks cluster id in the below property.

```
IKS_CLUSTER_ID=csadfdasd0ohsnstmnnqg
```

#### 5. Application Url

Update the bookinfo app url

```
APP_URL=http://1.1.1.1:31010/productpage?u=normal
```

## Run the demo

Run `sh demo.sh` to start the demo