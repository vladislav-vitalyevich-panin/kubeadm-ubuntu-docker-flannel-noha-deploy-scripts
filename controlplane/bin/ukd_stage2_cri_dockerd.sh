#####################################################################################
###                                    STAGE 2                                    ###
###                                   DOCKER CRI                                  ###
#####################################################################################

# Note: I used cri-dockerd because Docker Engine native Kubernetes support was dropped.
# Repo: https://github.com/Mirantis/cri-dockerd

# Install Git
apt-get install -y git

# Clone repo
git clone https://github.com/Mirantis/cri-dockerd.git

# Build cri-dockerd from source
cd cri-dockerd
mkdir bin


echo "Building cri-dockerd from source using golang - this will take 5-10 minutes..."

# The following command (the build) will take 5-10 minutes
go build -o bin/cri-dockerd
mkdir -p /usr/local/bin
install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd
cp -a packaging/systemd/* /etc/systemd/system
sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
systemctl daemon-reload
systemctl enable cri-docker.service
systemctl enable --now cri-docker.socket

# At this point you should have Docker CRI up and running



