# Accessing Kafka Topic messages

Document explains about how to access kafka topic messages in AI-Manager.

AI-Manager uses Strimzi Kafka Brokers. 

## Login to AI Manager installed OCP cluster.

1. Login into the cluster

```
oc login --token=YYYYYYYYYYYYYYYYYY --server=https://a111-e.us-south.containers.cloud.ibm.com:11111
```

2. Switch to the AI-Manager installed namespace

```
oc project devaiops
```

## Expose Strimzi Kafka Brokers (one time only)

1. Patch the strimzi cluster

    ```
oc patch Kafka strimzi-cluster -p '{"spec": {"kafka": {"listeners": {"external": {"type": "route"}}}}}' --type=merge

    ```

2. After few seconds, a route should be created. 

    Run the below command.

    ```
    oc get routes
    ```

    The output should have route with the name `strimzi-cluster-kafka-bootstrap`


## View Kafka messages

1. Get strimzi cluster `ca cert`

    ```
    oc extract secret/strimzi-cluster-cluster-ca-cert --keys=ca.crt --to=- > ca.crt
    ```

2. Get strimzi cluster `sasl password`

    ```
    export SASL_PASSWORD=$(oc get secret token --template={{.data.password}} | base64 --decode)
    ```

3. Get security text 

    ```
    export SEC="-X security.protocol=SSL -X ssl.ca.location=ca.crt -X sasl.mechanisms=SCRAM-SHA-512 -X sasl.username=token -X sasl.password=$SASL_PASSWORD"
    ```

4. Get `BROKER`

    ```
    export BROKER=$(oc get routes strimzi-cluster-kafka-bootstrap -o=jsonpath='{.status.ingress[0].host}{"\n"}'):443
    ```

5. Get messages from kafkatopics

    To list all the kafkatopics.

    ```
    oc get kafkatopics
    ```

    To see the messages from `derived-stories`

    ```
    kafkacat $SEC -b $BROKER -C -t derived-stories
    ```

    To see the `derived-stories` messages from the beginning

    ```
    kafkacat $SEC -b $BROKER -C -t derived-stories  -o beginning
    ```



## Post messages into Kafka topic

You can post the json messages into Kafka topic like the below.

    ```
    kafkacat $SEC -b $BROKER -P -t logs-logdna-vmsvhjhj-gw7qh6mp -l ./sockshop_test_abnormal_logs.json
    ```


## Reference 

#### Strimzi: Accessing Kafka using OpenShift Routes

https://github.ibm.com/watson-ai4it/ai4it/wiki/Strimzi:-Accessing-Kafka-using-OpenShift-Routes#expose-kafka-using-openshift-routes


#### AIOps Event Configuration

https://github.ibm.com/katamari/closed-beta/blob/master/playbook/aiops-event-config.md