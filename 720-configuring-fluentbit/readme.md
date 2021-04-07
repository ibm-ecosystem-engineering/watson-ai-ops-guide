# Fluent Bit Configuration

Fluent Bit helps to push cluster logs to Humio instance.

This article explains about Fluent Bit installation and configurations. 


## 1. Download Humio helm charts

1. Download humio helm charts from https://github.com/humio/humio-helm-charts

(Here the FluentBit charts are available under `humio-helm-charts/charts/humio-fluentbit`)

2. Copy this chart `humio-helm-charts` to some folder called `temp`


## 2. Update properties

### override property

A property file `files/override.yaml` is given here.

1. Copy the file to`temp` folder

2. Update the properties such as `Host, Repo and port` according to the need in `override.yaml`

```
  humioHostname: 1.2.3.4
  humioRepoName: sandbox

    port: 8080
```

3. The `Path` property is configured in such a way that the fluentbit pushes `bookinfo` logs only

The `Path` property is there under `inputConfig: |-` section.

```
Path             /var/log/containers/*bookinfo*.log
```

## 3. Install Fluent Bit

1. Create namespace `humio-agent`

```
kubectl create ns humio-agent
```

2. Go to the folder `files`

```
cd files
```

3. Run helm install to install fluentbit.

a. Replace the `<< HUMIO_TOKEN >>` with appropriate token below.

```
helm install humio ./humio-helm-charts \
  --namespace humio-agent \
  --set humio-fluentbit.token=<< HUMIO_TOKEN >> \
  --values ./override.yaml
```

b. Run the above command.

The helm should have been installed.

You may get output like this.

```
    .......
    .......
NAME: humio
LAST DEPLOYED: Wed Feb  3 19:06:07 2021
NAMESPACE: humio-agent
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

## 4. Uninstall Fluent Bit

 To uninstall fluentbit run the below command.

```
oc project humio-agent
helm delete humio
```

## References

https://docs.humio.com/docs/ingesting-data/log-formats/kubernetes/

https://github.com/humio/humio-helm-charts/blob/master/charts/humio-fluentbit/values.yaml

Fluent Bit in IBM Kubernetes Service with Humio
https://ongkhaiwei.medium.com/fluent-bit-in-ibm-kubernetes-service-with-humio-9d0e9eee61a5

Advanced Log Routing with Fluent Bit

https://docs.humio.com/training/use-cases/fluentbit-14/

https://docs.fluentbit.io/manual/v/1.4/concepts/data-pipeline/router

https://github.com/fluent/fluent-bit/issues/758

https://docs.fluentbit.io/manual/v/1.4/administration/configuring-fluent-bit/configuration-file

https://github.com/fluent/fluent-bit/issues/2174

https://fluentbit.io/documentation/0.13/about/fluentd_and_fluentbit.html

https://docs.humio.com/docs/ingesting-data/log-formats/kubernetes/