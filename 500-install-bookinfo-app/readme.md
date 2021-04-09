# Install BookInfo app in Kubernetes or Openshift

This article explains about how to install BookInfo app in Kubernetes or Openshift

1. Download Book info manifests files using the links

 https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo.yaml

 https://istio.io/latest/docs/examples/bookinfo/


2. Create a Namespace called `bookinfo`

  ```
  kubectl create ns bookinfo
  ```

3. We can use simple bookinfo app found in the yaml not the istio version.

  ```
  samples/bookinfo/platform/kube/bookinfo.yaml
  ```

4. Edit the `productpage` Service found in the `bookinfo.yaml` to expose as NodePort. 

  The yaml could look like this.

  ```
  apiVersion: v1
  kind: Service
  metadata:
    name: productpage
    namespace: bookinfo
    labels:
      app: productpage
      service: productpage
  spec:
    type: NodePort
    ports:
    - name: http
      nodePort: 31002
      port: 9080
      protocol: TCP
      targetPort: 9080
    selector:
      app: productpage
  ```

5. Run the yaml to install the book info app.

  ```
  kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
  ```

6. Get the EXTERNAL-IP to access the application

  ```
  $ kubectl get nodes -o wide

  NAME          STATUS     ROLES           AGE    VERSION           INTERNAL-IP   EXTERNAL-IP    OS-IMAGE   KERNEL-VERSION                CONTAINER-RUNTIME
  10.73.12.79   Ready      master,worker   128d   v1.17.1+c5fd4e8   10.73.12.79   1.2.3.4   Red Hat    3.10.0-1127.19.1.el7.x86_64   cri-o://1.17.5-7.rhaos4.4.git6b97f81.el7
  10.73.12.80   NotReady   master,worker   128d   v1.17.1+c5fd4e8   10.73.12.80   1.2.3.5   Red Hat    3.10.0-1127.19.1.el7.x86_64   cri-o://1.17.5-7.rhaos4.4.git6b97f81.el7
  10.73.12.81   Ready      master,worker   128d   v1.17.1+c5fd4e8   10.73.12.81   1.2.3.6   Red Hat    3.10.0-1127.19.1.el7.x86_64   cri-o://1.17.5-7.rhaos4.4.git6b97f81.el7
  10.73.12.90   Ready      master,worker   128d   v1.17.1+40d7dbd   10.73.12.90   1.2.3.7   Red Hat    3.10.0-1160.6.1.el7.x86_64    cri-o://1.17.5-11.rhaos4.4.git7f979af.el7
  ```

7. Access the application using the below url.

```
http://1.2.3.4:31002/productpage
```

1.2.3.4 is EXTERNAL-IP

31002 is the nodeport value (given in the `productpage` Service)

The `productpage` looks like this.

<img src="images/01-app.png">


