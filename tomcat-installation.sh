#!/bin/bash
# Tomcat installation process
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
echo "****************Download Tomcat Package********************"
echo "############################################################"
cd /opt
wget https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.109/bin/apache-tomcat-7.0.109.tar.gz
tar -xzf apache-tomcat-7.0.109.tar.gz
mv apache-tomcat-7.0.109 tomcat
rm  apache-tomcat-7.0.109.tar.gz
echo "############################################################"
echo "****************Create an Tomcat Service file********************"
echo "############################################################"
 
echo "[Unit]
Description=Apache Tomcat
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-11-openjdk 
Environment=CATALINA_PID=/opt/tomcat/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xmx1024M -server'

WorkingDirectory=/opt/tomcat

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=15
Restart=always

[Install]
WantedBy=multi-user.target" | sudo tee -a /etc/systemd/system/tomcat.service

echo "############################################################"
echo "****************SELINUX********************"
echo "############################################################"
sudo chcon -R -t bin_t /opt/tomcat

echo "############################################################"
echo "****************Start the Sonar service********************"
echo "############################################################"
sudo systemctl enable tomcat.service
sudo systemctl start tomcat.service
sudo systemctl status tomcat.service

