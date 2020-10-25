#!/usr/bin/env bash
#Create JMeter namespaces and deploy PODS with config on an existing kuberntes cluster

working_dir=$(pwd)

echo "checking if kubectl.exe is present"

if ! hash kubectl.exe 2>/dev/null
then
    echo "'kubectl.exe' was not found in PATH"
    echo "Kindly ensure that you can acces an existing kubernetes cluster via kubectl.exe"
    exit
fi

kubectl.exe version --short

echo "Current list of namespaces on the kubernetes cluster:"

echo

kubectl.exe get namespaces | grep -v NAME | awk '{print $1}'

echo

echo "Enter a new unique name of tenant, this will be used to create the namespace"
read tenant

echo
echo "Creating Namespace: $tenant"

kubectl.exe create namespace $tenant

echo "Namspace $tenant has been created"

echo

echo "Create environment variable config map"
#Creating environment variables in PODS
kubectl.exe create configmap -n $tenant env-variables --from-env-file=./variables.env
#kubectl.exe describe -n $tenant configmap/env-variables
#Testing transfering CSV data file
echo "Create parameter CSV file config map"
kubectl.exe create configmap -n $tenant csv-data --from-file=./test.csv

echo "Creating Jmeter slave replicas and service"

echo

kubectl.exe create -n $tenant -f jmeter_slaves_deploy.yaml

kubectl.exe create -n $tenant -f jmeter_slaves_svc.yaml

echo "Deploy configmap for test execution"
kubectl.exe create -n $tenant -f jmeter_master_configmap.yaml
echo "Deploy Jmeter Master"
kubectl.exe create -n $tenant -f jmeter_master_deploy.yaml


echo "Printout Of the $tenant Objects"

echo

kubectl.exe get -n $tenant all

echo namespace = $tenant > $working_dir/tenant_export
echo namespace = $tenant > $working_dir/monitor/tenant_export