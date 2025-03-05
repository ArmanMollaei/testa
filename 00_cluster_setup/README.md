# Cluster setup
## Vanilla (self-hosted) cluster
If you have already created the cluster (as per the main README), please execute the following steps to "finalize" the setup.
If not, create the cluster as mentioned in the main README.
### Install networking, ingress controller and MetalLB
Use the provided script `create-networking-ingress-controller-metallb.sh` for this.
### Create MetalLB advertisements and IP pools
In case of a self-hosted cluster, it's necessary to create these things as well because MetalLB won't take care of it on its own. \
**If necessary**, modify the predefined IP address pools in the provided manifest file `create-metallb-advertisements.yaml` to avoid collision with your home network's internal IP range. \
Lastly apply the provided manifest with kubectl: `kubectl apply -f create-metallb-advertisements.yaml`

## Cloud-hosted solution (AWS, GCP, Azure and so on)
If you prefer a cloud-hosted k8s service, the sole customization step should be to install an ingress controller. These clusters already have networking fabric installed and enabled (Calico). \
The software-defined loadbalancers will take care of the assignment of external IP-s and configuration of routing.
### Install NGINX ingress controller
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/cloud/deploy.yaml`
