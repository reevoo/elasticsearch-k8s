#!/bin/sh -xe

if [ "$NAMESPACE" = "" ]
then
  NAMESPACE='production'
fi

kubectl --namespace=$NAMESPACE delete -f es-data.yaml
kubectl --namespace=$NAMESPACE delete -f es-client.yaml
kubectl --namespace=$NAMESPACE delete -f es-master.yaml
kubectl --namespace=$NAMESPACE delete -f es-svc.yaml
kubectl --namespace=$NAMESPACE delete -f es-discovery-svc.yaml
