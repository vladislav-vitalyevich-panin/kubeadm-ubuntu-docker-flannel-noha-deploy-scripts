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



