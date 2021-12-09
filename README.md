# Nutanix Karbon Horizontal Pod Autoscale

This example shows how to use [Kubernetes HPA](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) with [Nutanix Karbon](https://www.nutanix.com/products/karbon).

For this purpose, I have developed a few scripts that will help you deploying [Kubernetes Metrics Server](https://github.com/kubernetes-sigs/metrics-server) latest version, create a simple php-apache deployment, and then enable HPA for this deployment.

# Scripts

## [1-Metrics-Server.sh](https://github.com/rafabolivar/karbon_hpa/blob/main/scripts/1-Metrics-Server.sh)

This script deploys Kubernetes the latest version of Metrics Server, so you can collect resource metrics from Kubelets and expose them in Kubernetes apiserver through [Metrics API](https://github.com/kubernetes/metrics) for use by [Horizontal Pod Autoscaler](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/) and [Vertical Pod Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler/).

## [2-HorizontalPodAutoscaling.sh](https://github.com/rafabolivar/karbon_hpa/blob/main/scripts/2-HorizontalPodAutoscaling.sh)
This script creates a namespace called `karbon-demo-hpa` and a simple php-apache deployment. Then, it enables HPA for the deployment with a target CPU utilization set to 50% and a number of replicas between 1 and 10:

    kubectl -n karbon-demo-hpa autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10

## [3-IncreaseLoad.sh](https://github.com/rafabolivar/karbon_hpa/blob/main/scripts/3-IncreaseLoad.sh)
This script generates load by issuing continuous `wget` requests to our php-apache deployment, each 0.01 seconds:

    kubectl -n karbon-demo-hpa run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"

## [4-CheckLoad.sh](https://github.com/rafabolivar/karbon_hpa/blob/main/scripts/4-CheckLoad.sh)
This script checks the load of our php-apache deployment:

    kubectl -n karbon-demo-hpa get deployment php-apache

You can use other commands to see the pods that are being created, as well as their load:

    kubectl -n karbon-demo-hpa get pods 
    kubectl -n karbon-demo-hpa top pods

## [5-CleanUp.sh](https://github.com/rafabolivar/karbon_hpa/blob/main/scripts/5-CleanUp.sh)
This script deletes the namespace created for the demo.

## [6-K8s_Dashboard.sh](https://github.com/rafabolivar/karbon_hpa/blob/main/scripts/6-K8s_Dashboard.sh)
This extra script, enables Kubernetes Dashboard:

    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.4.0/aio/deploy/recommended.yaml

# Prerequisites

You need a working Kubernetes cluster v1.19+, deployed with Nutanix Karbon. 


# Useful links

Here you have several links that can be useful to understand this example:

 - [Metrics Server installation on Nutanix Karbon example by Pipoe2h](https://github.com/pipoe2h/karbon/tree/main/metrics-server).
 - [Kubernetes Metrics Server on GitHub](https://github.com/kubernetes-sigs/metrics-server).
 - [Kubernetes Horizontal Pod Autoscale](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/).
