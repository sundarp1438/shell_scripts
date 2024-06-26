#!/bin/bash
# JFrog Artifactory installation process
echo "############################################################"
echo "****************Install Pre-requisites********************"
echo "############################################################"
yum install java-11* -y
yum install wget -y
yum install zip -y
echo "############################################################"
echo "****************Validate Java version********************"
echo "############################################################"
java --version
echo "############################################################"
echo "****************Download JFrog Package********************"
echo "############################################################"
cd /opt
wget https://releases.jfrog.io/artifactory/bintray-artifactory/org/artifactory/oss/jfrog-artifactory-oss/[RELEASE]/jfrog-artifactory-oss-[RELEASE]-linux.tar.gz
tar -xvf jfrog-artifactory-oss-[RELEASE]-linux.tar.gz
mv artifactory-oss-7.77.8 jfrog
rm -rf jfrog-artifactory-oss-[RELEASE]-linux.tar.gz
echo "############################################################"
echo "****************Create an JFrog Service file********************"
echo "############################################################"
 
echo "[Unit]
Description=jfrog service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=jfrog
Group=jfrog
ExecStart=/opt/jfrog/app/bin/artifactoryctl start
ExecStop=/opt/jfrog/app/bin/artifactoryctl stop
User=jfrog
Restart=on-abort

[Install]
WantedBy=multi-user.target" | sudo tee -a /etc/systemd/system/jfrog.service

echo "############################################################"
echo "****************SELINUX********************"
echo "############################################################"
sudo chcon -R -t bin_t /opt/jfrog/app/bin/artifactoryctl

echo "############################################################"
echo "****************Start the JFrog service********************"
echo "############################################################"
sudo systemctl enable jfrog.service
sudo systemctl start jfrog.service
sudo systemctl status jfrog.service

