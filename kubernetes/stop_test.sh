#!/usr/bin/env bash
#Script writtent to stop a running jmeter master test
#Kindly ensure you have the necessary kubeconfig

working_dir=`pwd`

#Get namesapce variable
tenant=`awk '{print $NF}' $working_dir/tenant_export`
tenant=jmeter

master_pod=`kubectl.exe get po -n $tenant | grep jmeter-master | awk '{print $1}'`

kubectl.exe exec -ti -n $tenant $master_pod -- bash -c '$JMETER_HOME/bin/stoptest.sh'
