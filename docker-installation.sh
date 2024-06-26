#!/bin/bash
# Docker installation process
echo "############################################################"
echo "****************Install Pre-requisites********************"
echo "############################################################"
yum install java-17* -y
yum install wget -y
yum install zip -y
echo "############################################################"
echo "****************Validate Java version********************"
echo "############################################################"
java --version
echo "############################################################"
echo "****************Configure the Docker repository********************"
echo "############################################################"
echo "
[docker-ce-stable]
name=Docker CE Stable - $basearch
baseurl=https://download.docker.com/linux/centos/$releasever/$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/centos/gpg" | sudo tee -a /etc/yum.repos.d/docker-ce.repo
echo "############################################################"
echo "****************Install Docker service********************"
echo "############################################################"
yum install docker-ce docker-ce-cli containerd.io -y
echo "############################################################"
echo "****************Run the Docker service********************"
echo "############################################################" 
systemctl enable docker
systemctl start docker
systemctl status docker
echo "############################################################"
echo "****************verify the Docker service********************"
echo "############################################################" 
docker version
docker info