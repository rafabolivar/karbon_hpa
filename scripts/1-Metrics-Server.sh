#!/bin/bash
# Credit goes to Pipoe2h: https://github.com/pipoe2h/karbon/blob/main/metrics-server/README.md

#kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.5.2/components.yaml
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

kubectl -n kube-system patch deployment metrics-server --type='json' -p '[
    {
        "op": "replace",
        "path": "/spec/template/spec/containers/0/args",
        "value": [
            "--cert-dir=/tmp",
            "--secure-port=4443",
            "--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname",
            "--kubelet-use-node-status-port",
            "--kubelet-insecure-tls"
        ]
    }
]'

sleep 15
kubectl top nodes
kubectl top pods
