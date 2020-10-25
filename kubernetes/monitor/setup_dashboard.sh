#!/usr/bin/env bash

working_dir=`pwd`

#Get namesapce variable
tenant=`awk '{print $NF}' $working_dir/tenant_export`

##Wait until Influxdb Deployment is up and running
##influxdb_status=`kubectl.exe get po -n $tenant | grep influxdb-jmeter | awk '{print $2}' | grep Running

## Create jmeter database automatically in Influxdb
EXTERNAL_IP=`kubectl.exe get svc | grep jmeter-grafana | awk '{print $4}'`

echo "Creating Influxdb jmeter Database"

influxdb_pod=`kubectl.exe get po | grep influxdb-jmeter | awk '{print $1}'`
kubectl.exe exec -ti $influxdb_pod -- influx -execute 'CREATE DATABASE jmeter'

echo "Creating the Grafana data source"
DATASRC_URL=`echo http://admin:admin@$EXTERNAL_IP:3000/api/datasources`

curl $DATASRC_URL -X POST -H 'Content-Type: application/json;charset=UTF-8' \
--data-binary '{"name":"jmeterdb","type":"influxdb","typeLogoUrl":"public/app/plugins/datasource/influxdb/img/influxdb_logo.svg", "url":"http://jmeter-influxdb:8086","access":"proxy","isDefault":true,"database":"jmeter","user":"admin","password":"admin","tlsSkipVerify":true,"version":"InfluxQL","readOnly":false}'
echo
sleep 5
echo
echo "Creating the Grafana Dashboard"
echo
DASHBOARD_URL=`echo http://admin:admin@$EXTERNAL_IP:3000/api/dashboards/import`

curl -X POST -i $DASHBOARD_URL -d "{\"dashboard\":$(cat ./jmeter_load_test.json)}" -H 'Content-Type: application/json;charset=UTF-8'

sleep 2
echo
URL=`echo http://$EXTERNAL_IP:3000/login`
echo 'Grafana Dashboard : ' $URL