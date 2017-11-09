#! /bin/bash

#Install dashboard
#kubectl create -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/kubernetes-dashboard/v1.6.3.yaml
kubectl create -f v1.6.3.yaml

#Install heapster (for future use)
kubectl create -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/monitoring-standalone/v1.7.0.yaml

#Install route53 mapper(Switched to external-dns, which also requires additional permissions in minion security group"
#kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/v1.3.0.yml
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/externaldns.yaml

#Runs helm, a kubernetes addons manager
helm init
sleep 15s
#Installs consul
helm repo update
sleep 5s
helm install --name my-consul --set DisableHostNodeId=true,ui.enabled=true,uiService.enabled=true,uiService.type=LoadBalancer,Replicas=3 stable/consul --version 0.4.2
#Install config for consul-register
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/config.yaml
sleep 10s
#Install kube-consul-register
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/rs.yaml

# Installing prometheus(collects prometheus/kubernetes metrics)
helm install stable/prometheus --name qpair-prom -f prometheus/values.yaml
sleep 5s

#Installing influxdb
helm install --name my-release -f influxdb/values.yaml stable/influxdb

#Install elasticsearch
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/es-controller.yaml
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/es-service.yaml
sleep 5s

#Install Kibana (This needs to be updated)
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/kibana-controller.yaml
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/kibana-service.yaml
sleep 5s

#Install fluentd as daemonset
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/fluentd-daemonset-elasticsearch.yaml
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/fluentd-service.yaml

#Install kube-ops-view
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/deploy/auth.yaml
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/deploy/deployment.yaml
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/deploy/ingress.yaml
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/deploy/redis-deployment.yaml
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/deploy/redis-service.yaml
kubectl create -f https://raw.githubusercontent.com/QpYujin/k8s-addon/master/deploy/service.yaml
