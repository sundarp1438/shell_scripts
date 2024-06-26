#!/bin/bash
# Maven installation process
echo "############################################################"
echo "***************************Install Java 11******************"
echo "############################################################"
yum install java-11* -y
yum install wget -y
echo "############################################################"
echo "***************************verify java******************"
echo "############################################################"
java --version
echo "############################################################"
echo "***************************download maven******************"
echo "############################################################"
cd /opt
wget https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
tar -xvf apache-maven-3.6.3-bin.tar.gz
mv apache-maven-3.6.3 maven
rm -rf apache-maven-3.6.3-bin.tar.gz

echo "############################################################"
echo "Add the path for maven to access from any where"
echo "############################################################"
echo "export MAVEN_HOME=/opt/maven" > /etc/profile.d/maven.sh
echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk" >>  /etc/profile.d/maven.sh
source  /etc/profile.d/maven.sh 
echo export PATH=${JAVA_HOME}/bin:${MAVEN_HOME}/bin:${PATH} >> /etc/profile.d/maven.sh

echo "############################################################"
echo "Loading file for reflecting changes"
echo "############################################################"
source  /etc/profile.d/maven.sh 

echo "###########################"
echo "Verify maven version" 
echo "############################"
mvn --version
