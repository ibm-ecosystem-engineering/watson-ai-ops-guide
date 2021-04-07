#!/bin/sh

echo "clear aimanager started ..... $(date)"

source ./config.sh

echo "........................................."
echo " Here are the parameters used in the script ... hope you have already done 'oc login ...' "
echo "     Namespace: $NAMESAPCE"
echo "     ApplicationGroupId: $APPLICATION_GROUP_ID"
echo "     ApplicationId: $APPLICATION_ID"
echo "........................................."
echo ""
echo ""
read  -p "Are you sure to run the cleanup script (y/n) : " answer

if [ "$answer" != "${answer#[Yy]}" ] ;then

        ##  Switch namesapce
        oc project $NAMESAPCE

        echo "Step 1: Delete kafkatopics"
        echo "--------------------------"
        oc delete kafkatopic windowed-logs-$APPLICATION_GROUP_ID-$APPLICATION_ID
        oc delete kafkatopics normalized-alerts-$APPLICATION_GROUP_ID-$APPLICATION_ID
        oc delete kafkatopic alerts-noi-$APPLICATION_GROUP_ID-$APPLICATION_ID
        oc delete kafkatopic alerts-pagerduty-$APPLICATION_GROUP_ID-$APPLICATION_ID
        oc delete kafkatopic logs-logdna-$APPLICATION_GROUP_ID-$APPLICATION_ID
        oc delete kafkatopic logs-humio-$APPLICATION_GROUP_ID-$APPLICATION_ID
        oc delete kafkatopics derived-stories

        echo "Step 2: Restart the pods"
        echo "------------------------"
        oc delete pod $(oc get pods | grep aio-log-anomaly | awk '{print $1;}')
        oc delete pod $(oc get pods | grep aio-event | awk '{print $1;}')


        echo "Step 3: Clear the database for stories"
        echo "--------------------------------------"

        echo "clearing ..."
        oc exec -it $(oc get pods | grep persistence | awk '{print $1;}') -- /bin/sh -c "curl -k -X DELETE https://localhost:8443/v2/similar_incident_lists"
        echo ""
        oc exec -it $(oc get pods | grep persistence | awk '{print $1;}') -- /bin/sh -c "curl -k -X DELETE https://localhost:8443/v2/alertgroups"
        echo ""
        oc exec -it $(oc get pods | grep persistence | awk '{print $1;}') -- /bin/sh -c "curl -k -X DELETE https://localhost:8443/v2/app_states"
        echo ""
        oc exec -it $(oc get pods | grep persistence | awk '{print $1;}') -- /bin/sh -c "curl -k -X DELETE https://localhost:8443/v2/stories"
        echo ""

        echo "check clear is success or not. The output should be []"
        oc exec -it $(oc get pods | grep persistence | awk '{print $1;}') -- /bin/sh -c "curl -k https://localhost:8443/v2/similar_incident_lists"
        echo ""
        oc exec -it $(oc get pods | grep persistence | awk '{print $1;}') -- /bin/sh -c "curl -k https://localhost:8443/v2/alertgroups"
        echo ""
        oc exec -it $(oc get pods | grep persistence | awk '{print $1;}') -- /bin/sh -c "curl -k https://localhost:8443/v2/application_groups/$APPLICATION_GROUP_ID/app_states"
        echo ""
        oc exec -it $(oc get pods | grep persistence | awk '{print $1;}') -- /bin/sh -c "curl -k https://localhost:8443/v2/stories"
        echo ""


        echo "Step 4: Refresh the Flink Jobs"
        echo "------------------------------"
        oc exec -it  $(oc get pods | grep aio-controller | awk '{print $1;}') -- /bin/sh -c "curl -k -X PUT https://localhost:9443/v2/connections/application_groups/$APPLICATION_GROUP_ID/applications/$APPLICATION_ID/refresh?datasource_type=logs"
        echo ""
        oc exec -it  $(oc get pods | grep aio-controller | awk '{print $1;}') -- /bin/sh -c "curl -k -X PUT https://localhost:9443/v2/connections/application_groups/$APPLICATION_GROUP_ID/applications/$APPLICATION_ID/refresh?datasource_type=alerts"
        echo " Refresh completed"

        echo "Step 5: Check the flink jobs are running"
        echo "----------------------------------------"
        echo "Run the below 2 commands and you should see the 2 jobs are running"
        echo "oc port-forward $(oc get pods | grep job-manager-0 | awk '{print $1;}') 8000:8000"
        echo "https://localhost:8000/#/overview"

        # echo "Step 6: Restart the pods again"
        # echo "------------------------------"
        # oc delete pod $(oc get pods | grep aio-log-anomaly | awk '{print $1;}')
        # oc delete pod $(oc get pods | grep aio-event | awk '{print $1;}')

        echo "Process done"
else
        echo "Process ..stopped"
fi

echo "clear aimanager completed ..... $(date)"
