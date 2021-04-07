# BookInfo Execution Plan - Steps and Activities

This document explains Steps and Activities involved in BookInfo application setup for Watson AI-Ops.

The article is based on the the following
 - RedHat OpenShift 4.5 on IBM Cloud (ROKS)
 - Watson AIOps 2.1

Here are the steps involved.

- 1: Watson AIOps (WA) 2.1 Installation
- 2: Pre-requisites on User Laptop / client linux system
- 3: Setup Managed Environment
- 4: Setup Operational Systems
- 5: Setup Initial Configurations in Watson AIOps 2.1
- 6: Train the Models in AI Manager
- 7: Integrate with various Operational Systems for Ops data ingestion
- 8: Create issues in the managed environment
- 9: Highlights, to check, in a slack story
- 10: Fix the issue based on suggestions in next-best-action


## 1: Watson AIOps (WA) 2.1 Installation

Refer : WA-2.1-Installation-Instructions-V1.2.docx

Environment : OCP


| S.No                 | Topic                     |Description                       | 
| -------------         | -------------                 |-------------              |
| 1         | Setup OpenShift |  Setup OpenShift (IBM ROKS) 4.6   |
| 2         | Setup WA catalog sources |  Setup WA catalog sources   |
| 3         | Install WA Operators |  Install WA Operators in OpenShift (Watson AIOps)   |
| 4         | Create  Service Accounts and Secrets |  Create necessary Service Accounts and Secrets (with IBM entitlement registry key)   |
| 5         | Create Instances of Event Manager |  Create Instances of Event Manager (including Topology Manager) |
| 6         | Create instance of AI Manager |  Create instance of AI Manager |


## 2: Pre-requisites on User Laptop  / client linux VM

Environment : User Laptop

| S.No                 | Topic                     |Description                       | Reference | 
| -------------         | -------------                 |-------------              |-------------              |
| 1         | Demo Script | Make a demo script to introduce anomaly (scale down the pod) into ratings-v1 micro-service of Bookinfo and ingest events into Event Manager, which should notify the SRE on slack with all incident info | [./90-demo-script](./90-demo-script) |
| 2         | Install Apache Benche | To create load on bookinfo app | https://httpd.apache.org/download.cgi |
| 3         | Other installs | Openshift CLI <BR> Kubectl CLi <BR> Curl <BR> jq   |  |

## 3: Setup Managed Environment (IKS)

Environment : Managed Env

### 3.1 Install Bookinfo app

Install Bookinfo app on the managed environment. Pick a namespace for this app as `bookinfo`.

#### Reference : 

Refer :

[../501-install-bookinfo-app-iks](../501-install-bookinfo-app-iks)

Other Reference : 

https://community.ibm.com/community/user/integration/blogs/jeya-gandhi-rajan-m1/2021/02/14/log-anomaly-detection-by-ai-manager-in-w-ai-ops

Section : 1. Install BookInfo app in Kubernetes or Openshift




<table>
    <tr>
        <td width="4%">S.No</td>
        <td width="28%">Title</td>
        <td width="40%">Description</td>
        <td width="8%">Environment</td>
        <td width="20%">Reference</td>
    </tr>
    <tr>
        <td>3.1</td>
        <td> Install Bookinfo app</td>
        <td>Install Bookinfo app on the managed environment. Pick a namespace for this app as `bookinfo`.</td>
        <td>
[../501-install-bookinfo-app-iks](../501-install-bookinfo-app-iks)

Other Reference : 

https://community.ibm.com/community/user/integration/blogs/jeya-gandhi-rajan-m1/2021/02/14/log-anomaly-detection-by-ai-manager-in-w-ai-ops

Section : 1. Install BookInfo app in Kubernetes or Openshift
        </td>
    </tr>
                
</table>



## 4: Setup Operational Systems

### 4.1 LogDNA

Skip this section, if you go for Humio

#### 4.1.1 Installing LogDNA

Configure LogDNA instance in IBM cloud.

Environment : IBM Cloud

##### Reference : 

[../700-configuring-logdna](../700-configuring-logdna)

Section : 1. Create LogDNA Instance

#### 4.1.2 Install LogDNA Agent

Install LogDNA Agent instance in Managed env, where the app is installed.

Environment : Managed env.

##### Reference : 

Refer 1:

[../701-configuring-logdna-agent-iks](../701-configuring-logdna-agent-iks)

Refer 2: https://cloud.ibm.com/docs/log-analysis?topic=log-analysis-config_agent_kube_cluster

### 4.2 Humio

Skip this section, if you go for LogDNA

### 4.2.1 Install Humio

Setup Humio on a single node (16 core, 64 GB)

Environment : Any VM

#### Reference : 

https://github.com/diimallya/humio-single-node


### 4.2.2 Install fluentbit

Push the bookinfo logs to Humio (using Fluent-bit data shipper)

Configure Fluentbit to push logs corresponding to bookinfo namespace only (or else there would be too much traffic on the network and also storage gets filed on humio vm quickly).

Environment : Managed env

#### Reference : 

Refer: [./14-fluentbit/iks](./14-fluentbit/iks)

Other Reference : https://docs.humio.com/docs/ingesting-data/log-formats/kubernetes/


### 4.3 Create Slack acccount

Setup free slack account and create workspace

Environment : Slack

#### Reference : 

https://slack.com/get-started#/create



## 5: Setup Initial Configurations in Watson AIOps 2.1

<table>
    <tr>
        <td width="4%">S.No</td>
        <td width="28%">Title</td>
        <td width="40%">Description</td>
        <td width="8%">Environment</td>
        <td width="20%">Reference</td>
    </tr>
    <tr>
        <td>5.1</td>
        <td>Integrate with Slack</td>
        <td>Integrate with Slack collaboration platform. Need to copy nginx certificate as well.</td>
        <td>AI-Manager</td>
        <td>
            
[./22-slack](./22-slack)
        </td>
    </tr>
    <tr>
        <td>5.2</td>
        <td>Create application groups and applications</td>
        <td>Create application groups and applications
</td>
        <td>AI-Manager</td>
        <td>
        
https://community.ibm.com/community/user/aiops/blogs/jeya-gandhi-rajan-m1/2021/02/09/configuring-ai-manager-in-watson-ai-ops

Section : 
- 2.1 Application Group Configuration
- 2.3 Application at Application Group Level    
        </td>
    </tr>
    <tr>
    <td> 5.3</td>
    <td>Prepare Topology</td>
    <td>Create the topology of bookinfo in the Topology Manager.</td>
    <td>Topology-Manager</td>
    <td>
    Refer :  [./32-topology-creation](./32-topology-creation)

Other Reference :  https://github.com/GandhiCloudLab/ibm-ai-ops-blog/tree/master/400-topology-observer-job-config
    </td>
    </tr>
    <tr>
        <td>5.4</td>
        <td>Create runbooks</td>
        <td>Create runbooks in 'Event Manager' to resolve the issue (to scale the pod count to 1)</td>
        <td>Event-Manager</td>
        <td>
[./62-runbook](./62-runbook)        
        </td>
    </tr>
                
</table>



## 6: Train the Models in AI Manager

Environment : AI-Manager

<table>
    <tr>
        <td width="4%">S.No</td>
        <td width="28%">Title</td>
        <td width="48%">Description</td>
        <td width="20%">Reference</td>
    </tr>
    <tr>
        <td>6.1</td>
        <td></td>
        <td></td>
        <td></td>
        <td>
        </td>
    </tr>
    <tr>
        <td>6.1.1</td>
        <td>Generate Load</td>
        <td>Generate the load for the bookinfo app.</td>
        <td>

[./19-bookinfo-load-generation](./19-bookinfo-load-generation)
        </td>
    </tr>
    <tr>
        <td>6.1.2</td>
        <td>Download logs</td>
        <td>Collect the normal logs.</td>
        <td>
[./20-download-logs](./20-download-logs)
        </td>
    </tr>
    <tr>
        <td>6.1.3</td>
        <td>Start Training</td>
        <td>Train the models in AI Manager.</td>
        <td>
Refer :  [./50-training-logs](./50-training-logs)

Other Reference : https://community.ibm.com/community/user/aiops/blogs/jeya-gandhi-rajan-m1/2021/02/10/training-log-anomaly-models-for-ai-manager
        </td>
    </tr>        
    <tr>
        <td>6.2</td>
        <td>Event group in AI Manager</td>
        <td>
For event group in AI Manager
- get sample events
- train the models in AI Manager        
        </td>
        <td>
Refer :  [./51-training-events](./51-training-events)

Other Reference : https://community.ibm.com/community/user/integration/blogs/jeya-gandhi-rajan-m1/2021/02/23/training-events-for-ai-manager-in-watson-aiops        
        </td>
    </tr>
    <tr>
        <td>6.3</td>
        <td>Similar incidents and next-best-action</td>
        <td>
For similar incidents and next-best-action
- get sample incidents from ServiceNow (or such tool)
- train the models in AI Manager
        </td>
        <td>

Refer :  [./52-training-similar-incidents](./52-training-similar-incidents)

Other Reference : https://community.ibm.com/community/user/integration/blogs/jeya-gandhi-rajan-m1/2021/02/23/training-similar-incidents-for-ai-manager-in-watso        
        </td>
    </tr>
                
</table>


## 7: Integrate with various Operational Systems for Ops data ingestion

<table>
    <tr>
        <td width="4%">S.No</td>
        <td width="28%">Title</td>
        <td width="40%">Description</td>
        <td width="8%">Environment</td>
        <td width="20%">Reference</td>
    </tr>
    <tr>
        <td>7.1</td>
        <td>Integration with Humio <BR> (Skip this section if LogDNA is used)</td>
        <td>Create Ops Integration with Humio from AI Manager</td>
        <td>AI-Manager</td>
        <td>
https://community.ibm.com/community/user/aiops/blogs/jeya-gandhi-rajan-m1/2021/02/09/configuring-ai-manager-in-watson-ai-ops


Section: 3.1.2 Integration with Humio and Kafka
        </td>
    </tr>
    <tr>
        <td>7.2</td>
       <td>Integration with LogDNA (Skip this section if Humio is used)</td>
        <td>Create Ops Integration with LogDNA from AI Manager</td>
        <td>AI-Manager</td>
        <td>
https://community.ibm.com/community/user/aiops/blogs/jeya-gandhi-rajan-m1/2021/02/09/configuring-ai-manager-in-watson-ai-ops


Section: 3.1.1 Integration with LogDNA and Kafka
        </td>
    </tr>
    <tr>
        <td>7.3</td>
        <td>Setup XML gateway</td>
        <td>Setup XML gateway and configure to integrate Event Manager with AI Manager </td>
        <td>OCP</td>
        <td>[../451-configuring-xml-gateway](../451-configuring-xml-gateway)</td>
    </tr>
    <tr>
        <td>7.4</td>
        <td>Integration with Topology Manager</td>
        <td>Create Ops integration with Topology Manager from AI Manager</td>
        <td>AI-Manager</td>
        <td>
[./42-topology-integration](./42-topology-integration)

Other Reference : 

https://community.ibm.com/community/user/aiops/blogs/jeya-gandhi-rajan-m1/2021/02/09/configuring-ai-manager-in-watson-ai-ops

Section: 2.2.1 ASM (Netcool Agile Service Manager) Configuration
        </td>
    </tr>
    <tr>
        <td>7.5</td>
        <td>Expose Event Manager</td>
        <td>Need to expose Event Manager to push events.</td>
        <td>AI-Manager</td>
        <td>[./82-eventmgr-expose](./82-eventmgr-expose)</td>
    </tr>
</table>


## 8: Create issues in the managed environment

| S.No                 | Topic                     |Description                       | Reference | 
| -------------         | -------------                 |-------------              |-------------              |
| 1         | Induce Error | Scale down the ratings-v1 pod to 0 by executing the demo script | [./90-demo-script](./90-demo-script) |
| 2         | Check Slack Stories | Check the stories created by WA |  |


## 9: Highlights, to check, in a slack story

| S.No                 | Topic                     |Description                       | 
| -------------         | -------------                 |-------------              |
| 1         | Basic incident info |  Basic incident info like title and description of the problem identified using AI and automation by WA |
| 2         | Localization|  Localization of a problem |
| 3         | Blast-radius|  Blast-radius due to current problem |
| 4         | Alerts|  Evidence data in the form of Alerts (with links to console) |
| 5         | Log anomalies|  Evidence data in the form of Log anomalies (with links to console) |
| 6         | Similar incidents|  Similar incidents through search recommendations (with links to incidents in different repositories like ServiceNow) |
| 7         | Edit incident|  Edit incident to change the title, severity etc |
| 8         | Acknowledge|  Acknowledge the incident and change status, create slack channel, invite other Ops team members etc |


## 10: Fix the issue based on suggestions in next-best-action

| S.No                 | Topic                     |Description                       | Reference | 
| -------------         | -------------                 |-------------              |-------------              |
| 1         | Fixing Error |  Trigger runboook which includes automation |[./62-runbook](./62-runbook)|


