#!/bin/sh -xe

if [ "$NAMESPACE" = "" ]
then
  NAMESPACE='production'
fi

kubectl --namespace=$NAMESPACE create -f es-discovery-svc.yaml
kubectl --namespace=$NAMESPACE create -f es-svc.yaml

kubectl --namespace=$NAMESPACE create -f es-master.yaml

# Wait for master to come up
sleep 120s

kubectl --namespace=$NAMESPACE scale deployment/es-master --replicas=3

kubectl --namespace=$NAMESPACE create -f es-client.yaml
kubectl --namespace=$NAMESPACE scale deployment/es-client --replicas=3

kubectl --namespace=$NAMESPACE create -f es-data.yaml
kubectl --namespace=$NAMESPACE scale deployment/es-data --replicas=3
