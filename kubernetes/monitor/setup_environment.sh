#!/usr/bin/env bash
#Create JMeter namespaces and deploy PODS with config on an existing kuberntes cluster

working_dir=$(pwd)
#Get namesapce variable
tenant=`awk '{print $NF}' "$working_dir/tenant_export"`

echo "checking if kubectl.exe is present"

if ! hash kubectl.exe 2>/dev/null
then
    echo "'kubectl.exe' was not found in PATH"
    echo "Kindly ensure that you can acces an existing kubernetes cluster via kubectl.exe"
    exit
fi

kubectl.exe version --short

echo "Creating Influxdb and the service"
#Create settings ini file
kubectl.exe create -f jmeter_influxdb_configmap.yaml
#Create persistent storage claim
kubectl.exe apply -f jmeter_influxdb_volumeclaim.yaml 

kubectl.exe create -f jmeter_influxdb_deploy.yaml

kubectl.exe create -f jmeter_influxdb_svc.yaml

echo "Creating Grafana Deployment"

kubectl.exe create -f jmeter_grafana_deploy.yaml

kubectl.exe create -f jmeter_grafana_svc.yaml

echo "Printout Of the $tenant Objects"

echo
echo "Printout Of the $tenant namespace Objects"
kubectl.exe get -n $tenant all
echo
echo "Printout Of the default namespace Objects"
kubectl.exe get all