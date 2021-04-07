# Installing Bookinfo in IKS

The Bookinfo can be downloaded from the below url.

https://raw.githubusercontent.com/istio/istio/master/samples/bookinfo/platform/kube/bookinfo.yaml


The modified `bookinfo.yaml` is available here and it can be installed.


1. Create a bookinfo namespace

```
kubectl create ns bookinfo
```

2. Apply the `bookinfo.yaml`

```
kubectl apply -f bookinfo.yaml
```

3. You can follow steps given [here](../500-install-bookinfo-app), to access the bookinfo app.

## Reference:

