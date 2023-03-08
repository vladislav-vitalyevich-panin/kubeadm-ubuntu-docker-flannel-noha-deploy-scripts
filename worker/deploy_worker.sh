PATH=$PATH:/usr/local/go/bin

echo "Stage 1 Start: Docker Engine installation"
./bin/ukd_stage1_docker.sh
echo "Stage 1 End"

echo "Stage 2 Start: CRI-Dockerd shim installation"
./bin/ukd_stage2_cri_dockerd.sh
echo "Stage 2 End"

echo "Stage 3 Start: kubeadm installation"
./bin/ukd_stage3_kubeadm.sh
echo "Stage 3 End"


echo "Installation is not complete! Please join this worker node to the cluster."
echo "If you're getting a 'multiple socket endpoints', append --cri-socket unix:///var/run/cri-dockerd.sock to the join command"
