#!/usr/bin/env bash

# As Flannel is practically deprecated in favor of Calico/Tigera, 
# I'll hereby remove it from the script as well.

# Creating Calico and Tigera with custom pod address range
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/tigera-operator.yaml
curl -sL https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/custom-resources.yaml -O
sed -i.bak 's,192.168.0.0/16,10.244.0.0/16,g' ./custom-resources.yaml
kubectl apply -f ./custom-resources.yaml && rm ./custom-resources.yaml*
echo 'Waiting 240 seconds to ensure Calico was started.'
sleep 240

# Deploy MetalLB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.9/config/manifests/metallb-native.yaml
echo 'Waiting 120 seconds to ensure MetalLB was started.'
sleep 120

# Deploy NGINX ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0/deploy/static/provider/cloud/deploy.yaml
echo 'Waiting 120 seconds to ensure NGINX ingress controller was started.'
sleep 120

# Delete ValidatingWebhookConfiguration-s
kubectl delete -A ValidatingWebhookConfiguration metallb-webhook-configuration
kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
