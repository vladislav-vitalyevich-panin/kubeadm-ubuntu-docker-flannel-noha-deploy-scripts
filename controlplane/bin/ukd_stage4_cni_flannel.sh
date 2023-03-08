#####################################################################################
###                               STAGE 4 (CONTROL PLANE)                         ###
###                             FLANNEL CNI (Pod Networking)                      ###
#####################################################################################


# Flannel was recommended for Hetzner deployment, and it seems to be easy to install. Repo:
# https://github.com/flannel-io/flannel

# Note that this script assumes that pod CIDR is 10.244.0.0/16 - if it's not, modify .yml below
# prior to use
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

