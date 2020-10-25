#!/usr/bin/env bash
#Create admin user

kubectl.exe apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

#Accessing the Dashboard UI <br />
kubectl.exe apply -f admin-user.yml 
kubectl.exe apply -f cluster-role.yml

kubectl.exe proxy &