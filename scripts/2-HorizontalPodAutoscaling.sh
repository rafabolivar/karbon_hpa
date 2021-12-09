#!/bin/bash
# Credit goes to Pipoe2h: https://github.com/pipoe2h/karbon/blob/main/horizontal-pod-autoscaler/README.md

kubectl create namespace karbon-demo-hpa

kubectl -n karbon-demo-hpa apply -f https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/php-apache.yaml

kubectl -n karbon-demo-hpa autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10

kubectl -n karbon-demo-hpa get hpa

