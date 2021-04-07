# Setup VM

Setup VM to login into IKS.

### Install IBMCloud CLI

To install ibmcloud cli in Linux run following commands

```bash
curl -fsSL https://clis.cloud.ibm.com/install/linux | sh
```

### Install IBMCloud plugins

To install ibmcloud plugins run following commands

```bash
ibmcloud plugin install container-registry

ibmcloud plugin install kubernetes-service
```

### Install kubectl

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

### Cluster config 

Get the required cluster config details

ibmcloud ks cluster config --cluster bvqsvmod0125spct9av0
kubectl config current-context
kubectl config set-context --current --namespace=bookinfo
