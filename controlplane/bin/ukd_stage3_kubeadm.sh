#####################################################################################
###                                    STAGE 3                                    ###
###                             KUBEADM (KUBECTL, KUBELET)                        ###
#####################################################################################

# APT should be set to use HTTPS at this stage.

# Update package index and install kubelet kubeadm kubectl
apt-get update
apt-get install -y kubelet kubeadm kubectl

# We should prevent auto-upgrades on core kubernetes software, so we mark them
apt-mark hold kubelet kubeadm kubectl

kubeadm init --pod-network-cidr=10.244.0.0/16  --cri-socket unix:///var/run/cri-dockerd.sock

# Get admin kubeconfig
mkdir -p /root/.kube
cp /etc/kubernetes/admin.conf /root/.kube/config

mkdir -p $HOME/.kube
cp /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

