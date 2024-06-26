#!/bin/bash
# Java installation process
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

