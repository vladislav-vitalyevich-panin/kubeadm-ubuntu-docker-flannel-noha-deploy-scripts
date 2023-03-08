# kubeadm-ubuntu-docker-flannel-noha-deploy-scripts
This repository contains a set of scripts that are designed to install a Kubernetes cluster with a single control plane node, with docker CRI and flannel CNI, on an Ubuntu-based system.


## Introduction
This repository contains a set of scripts, that are designed to install a Kubernetes cluster with a single control plane node.
The scripts are designed to be used on an Ubuntu system - they were tested on Ubuntu 20.04 image on three Hetzner Cloud instances (CX11, CX21 and CX21).

**This installation is NOT meant to be used for large scale or production environments. 
It is not possible to convert a cluster made by this script set to a highly-available cluster! (As stated in the kubeadm documentation)**

The final cluster is using the following packages:
1) kubeadm - cluster bootstrapping
2) docker-ce - Docker Engine, used for cluster CRE
3) cri-dockerd - Docker Engine as CRI support was dropped by kubeadm team, so we need an alternative shim.
   * GoLang - to build the cri-dockerd from source
4) flannel - Used for cluster CNI

Resulting cluster will have one control plane node and as much worker nodes as you'll set up.

## Prerequisites

The script will download all necessary tools and programs by itself **except for golang**.
You need to ensure the following:

1. You have Go installed (version 1.16 or later - prior versions have a bug which makes building cri-dockerd impossible) according to the instructions on it's website.
   * **Do NOT use apt-get install golang or apt-get install golang-go!** These are not maintained by the Go team and are outdated, and both contain the aforementioned bug.
   * If you have installed Go in a non-default directory (i.e. not according to it's website instructions), 
     please modify the PATH definition in each startup script (for control_node_deploy.sh and deploy_worker.sh at the file start).
2. You have a properly set up network - you can reach apt repositories and nodes can reach each other.
3. Your apt-get repository cache is updated.
   * Run **apt-get update** before starting the scripts to update it.

## How To Use
First, ensure that you have the prerequisites from above, and that every script in each folder has execution permissions.

Then, run prerequisites.sh and, if you don't have Go installed, install_go.sh (or preferably install Go via the instructions on their site).

Choose the correct install script:
   * If you are creating a control plane node, cd to "control_plane" directory and use the control_node_deploy.sh
   * If you are creating a worker node, cd to "worker" directory and use the script deploy_worker.sh and after that join the node.
   
Run the correct script on the node, and if it's a worker node - join it to the control node.

Note: If you are getting "Found multiple CRI endpoints on the host." error on attempt to join, append --cri-socket unix:///var/run/cri-dockerd.sock to the join command.

This project is licensed under the terms of the MIT license, the copy of which is located in this repository (LICENSE file).

