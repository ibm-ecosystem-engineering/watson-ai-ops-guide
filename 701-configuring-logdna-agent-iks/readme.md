# LogDNA Agent Configuration in IKS

### Connecting LogDNA agent to Kubernetes cluster

If you want to connect to Kubernetes cluster, you can follow the IBM Cloud documentation https://cloud.ibm.com/docs/Log-Analysis-with-LogDNA?topic=Log-Analysis-with-LogDNA-config_agent_kube_cluster

To prevent the other logs from the cluster to send to LogDNA by adding a evironment varilable `LOGDNA_EXCLUSION_RULES`.

So add the below line under `env:` in the `DaemonSet` found in the above downloaded yaml. This would stop almost all the other logs to reach LogDNA.

```
    - name: LOGDNA_EXCLUSION_RULES
        value: "/var/log/!(containers)*,/var/log/containers/productpage-*,/var/log/containers/reviews*,/var/log/containers/details*,/var/log/containers/kubernetes-*,/var/log/containers/olm-*,/var/log/containerd*,/var/log/syslog,/var/log/containers/weave*,/var/log/containers/*calico*,/var/log/containers/logdna*,/var/log/containers/dashboard*,/var/log/containers/metrics*,/var/log/containers/ibm*"
```

### Steps

1. Create ibm-observe namespace

```
kubectl create namespace ibm-observe
```

2. Create secret.

Replace < LogDNA_ingestion_key > below and run it.

```
kubectl create secret generic logdna-agent-key --from-literal=logdna-agent-key=<LogDNA_ingestion_key> -n ibm-observe
```

3. Verify Exclusion Rules in the file `/files/agent-resources.yaml`

```
            - name: LOGDNA_EXCLUSION_RULES
              value: "/var/log/!(containers)*,/var/log/containers/kubernetes-*,/var/log/containers/olm-*,/var/log/containerd*,/var/log/syslog,/var/log/containers/weave*,/var/log/containers/*calico*,/var/log/containers/logdna*,/var/log/containers/dashboard*,/var/log/containers/metrics*,/var/log/containers/ibm*"

```


4. Deploy the agent

```
kubectl apply -f ./files/agent-resources.yaml
```
