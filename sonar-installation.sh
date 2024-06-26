#!/bin/bash
# SonarQube installation process
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
echo "****************Download SonaQube Package********************"
echo "############################################################"
cd /opt
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.10.61524.zip
unzip sonarqube-8.9.10.61524.zip
mv sonarqube-8.9.10.61524 sonarqube
rm -rf sonarqube-8.9.10.61524.zip
echo "############################################################"
echo "****************Create an Sonar Service file********************"
echo "############################################################"
 
echo "[Unit]
Description=sonar service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=sonar
Group=sonar
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Restart=on-abort

[Install]
WantedBy=multi-user.target" | sudo tee -a /etc/systemd/system/sonar.service

echo "############################################################"
echo "****************SELINUX********************"
echo "############################################################"
sudo chcon -R -t bin_t /opt/sonarqube/bin/linux-x86-64/sonar.sh

echo "############################################################"
echo "****************Start the Sonar service********************"
echo "############################################################"
sudo systemctl enable sonar.service
sudo systemctl start sonar.service
sudo systemctl status sonar.service

