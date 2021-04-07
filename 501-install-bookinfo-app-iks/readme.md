# Install BookInfo app in Kubernetes or Openshift

This article explains about how to install BookInfo app in Kubernetes

### 1. Bookinfo app Download

1. The bookinfo app is downloaded from the link https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo.yaml

2. The images refered in the yaml is modified.

3. The `productpage` service is exposed as NodePort and value is `31010`.

4. The above modified file is available  in [./files/bookinfo.yaml](./files/bookinfo.yaml)

### 2. Create Namesapce

Create a Namespace called `bookinfo`

```
kubectl create ns bookinfo
```

### 3. Deploy Bookinfo

 Apply the yaml to install the book info app.

  ```
  kubectl apply -f ./files/bookinfo.yaml
  ```

### 4. Get EXTERNAL-IP

Get the EXTERNAL-IP to access the application

  ```
  $ kubectl get nodes -o wide

  NAME          STATUS     ROLES           AGE    VERSION           INTERNAL-IP   EXTERNAL-IP    OS-IMAGE   KERNEL-VERSION                CONTAINER-RUNTIME
  10.73.12.79   Ready      master,worker   128d   v1.17.1+c5fd4e8   10.73.12.79   1.2.3.4   Red Hat    3.10.0-1127.19.1.el7.x86_64   cri-o://1.17.5-7.rhaos4.4.git6b97f81.el7
  10.73.12.80   NotReady   master,worker   128d   v1.17.1+c5fd4e8   10.73.12.80   1.2.3.5   Red Hat    3.10.0-1127.19.1.el7.x86_64   cri-o://1.17.5-7.rhaos4.4.git6b97f81.el7
  10.73.12.81   Ready      master,worker   128d   v1.17.1+c5fd4e8   10.73.12.81   1.2.3.6   Red Hat    3.10.0-1127.19.1.el7.x86_64   cri-o://1.17.5-7.rhaos4.4.git6b97f81.el7
  10.73.12.90   Ready      master,worker   128d   v1.17.1+40d7dbd   10.73.12.90   1.2.3.7   Red Hat    3.10.0-1160.6.1.el7.x86_64    cri-o://1.17.5-11.rhaos4.4.git7f979af.el7
  ```

### 5. Access the app

Access the application using the below url.

```
http://1.2.3.4:31010/productpage
```

The `productpage` looks like this.

<img src="images/01-app.png">


