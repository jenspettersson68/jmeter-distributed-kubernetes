#!/usr/bin/env bash
#Script created to launch Jmeter tests directly from the current terminal without accessing the jmeter master pod.
#It requires jmx file in same directory
#After execution, test script jmx file may be deleted from the pod itself but not locally.
#Run script with ./run_test.sh <jmx-file>

# Get the namespace from file
working_dir=$(pwd)

#Get namesapce variable
tenant=`awk '{print $NF}' "$working_dir/tenant_export"`

echo 'Running test in namespace' $tenant

#Get Master pod details

master_pod=`kubectl.exe get po -n $tenant | grep jmeter-master | awk '{print $1}'`

#Cleaning up if running more than one test
kubectl.exe exec -ti -n $tenant $master_pod -- bash -c 'rm -rf /loadtest/report/'
kubectl.exe exec -ti -n $tenant $master_pod -- bash -c 'rm -f /results.jtl'
#Copy JMX file to pod
kubectl.exe cp $1 -n $tenant $master_pod:/$1

## Echo Starting Jmeter load test
kubectl.exe exec -ti -n $tenant $master_pod -- bash /loadtest/load_test $1
#Copy report to host
timestamp=$(date +'%Y%m%d_%H%M%S')
kubectl.exe cp -n $tenant $master_pod:loadtest/report ./report_$timestamp


