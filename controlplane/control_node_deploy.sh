PATH=$PATH:/usr/local/go/bin

echo "NOTE: If the installation fails on preflight checks, and if you are confident that your system can handle kubeadm requirements, go to ukd_stage3_kubeadm.sh"
echo "and add --ignore-preflight-errors=NumCPU to the kubeadm init command"
echo "Stage 1 Start: Docker Engine installation"
./bin/ukd_stage1_docker.sh
echo "Stage 1 End"

echo "Stage 2 Start: CRI-Dockerd shim installation"
./bin/ukd_stage2_cri_dockerd.sh
echo "Stage 2 End"

echo "Stage 3 Start: kubeadm installation"
./bin/ukd_stage3_kubeadm.sh
echo "Stage 3 End"

echo "Stage 4 Start: flannel installation"
./bin/ukd_stage4_cni_flannel.sh
echo "Stage 4 End"

echo "Are you using external cloud provider for nodes?"
echo ""
read -p "(If you use KUBELET_EXTRA_ARGS=--cloud-provider=external then the answer to the above is 'y') [Y/n] >" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Patching flannel to tolerate uninitialized taint..."
	kubectl -n kube-flannel patch ds kube-flannel-ds --type json -p '[{"op":"add","path":"/spec/template/spec/tolerations/-","value":{"key":"node.cloudprovider.kubernetes.io/uninitialized","value":"true","effect":"NoSchedule"}}]'
	echo "Done."
fi

echo "If you answered No, but you do use the flag, you need to patch kube-flannel-ds using the command, which is commented under this line in the control_node_deploy.sh"
# Using this:
# kubectl -n kube-flannel patch ds kube-flannel-ds --type json -p '[{"op":"add","path":"/spec/template/spec/tolerations/-","value":{"key":"node.cloudprovider.kubernetes.io/uninitialized","value":"true","effect":"NoSchedule"}}]'

echo "Control Plane node installation complete."
echo "Please copy the kubeadm join command to proceed with worker nodes."