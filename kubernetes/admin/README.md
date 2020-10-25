
# Kubernetes
This folder holds script for setting up an admin dashboard locally for K8, This is not necessary in GCP (GKE).<br /><br />
Local K8 Dashboard:<br />
https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/
<br />
Local User:<br />
https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md


kubectl.exe apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml<br />
Accessing the Dashboard UI <br />
```
kubectl apply -f admin-user.yml <br />
kubectl apply -f cluster-role.yml <br /><br />
kubectl proxy <br />
```
or run:
```
./create:admin.sh
```
NOTE: If running script - To kill the proxy:
```
ps -ef | grep kubectl
kill -9 <procID>
```
For Bash:

kubectl.exe -n kubernetes-dashboard describe secret $(kubectl.exe -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')

copy token e.g.

eyJhbGciOiJSUzI1NiIsImtpZCI6IlkyNG5GUGwtLUtuN1NpQ3hUaDN6M3d6Q2NsVmpTSkNNSGtoRmRHMTlOZ1EifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyLXRva2VuLTZzcGc0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiIxYmZiNDk1Ni01MGI4LTRiZTItODZhMS1kMmY4ODM0MDJhN2MiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXJuZXRlcy1kYXNoYm9hcmQ6YWRtaW4tdXNlciJ9.MyefRx1Cc2w_QbpZDmUgZfso_mzfBEWvC_3_J5TjesWtY2Da7LG0x075L_767C-LIpcEiQ32PNvsSDaHc2EXb6r3LTlwVy2Ljtf9CdW7bOACsY6G7VlfKT5EIbipw19c0A3yAxg3nK1EmfBY67i9DlS538HyBg2Qsn639yN59OTPjVcLc83AhpxhC0LB4FefzqUTwD2pMWqw5PewuYG5YZBbFaX6O1XofVs3T9xhFcR3ru4kAzzp82w7OoFGwm2LNnRz-QBZw00n_F_ExWzLSoZ_IRXFyMCanELNMKeWJg35ZpsorX5EdolD5-9Mt0jthy_Mntxh0aNGBSgSat8oIA
<br /><br />
Accessing Web Dahboard UI<br />
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/