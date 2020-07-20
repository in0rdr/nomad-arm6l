#!/bin/bash

sudo apt-get update
sudo apt-get install -y git build-essential curl binutils-arm-linux-gnueabi gcc-5-arm-linux-gnueabi gcc-5-multilib-arm-linux-gnueabi

curl -L -o ~/${go_version}.tar.gz https://dl.google.com/go/${go_version}.tar.gz
tar -C /usr/local -xzf ~/${go_version}.tar.gz
mkdir /root/go

mkdir -p /root/.ssh
echo "GOPATH=/root/go" >>/root/.ssh/environment
echo "PATH=$PATH:/usr/local/go/bin:/root/go/bin" >>/root/.ssh/environment
echo "PermitUserEnvironment yes" >>/etc/ssh/sshd_config

mkdir -p ${GOPATH}/src/github.com/hashicorp
git clone --branch ${nomad_version} https://github.com/hashicorp/nomad.git ${GOPATH}/src/github.com/hashicorp/nomad

curl -sfL https://install.goreleaser.com/github.com/goreleaser/goreleaser.sh | sh