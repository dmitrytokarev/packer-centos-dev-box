#!/usr/bin/env bash

# update system
sudo yum update -y

# install Java (OpenJDK)
sudo yum -y install java

# install Python 3
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y https://centos7.iuscommunity.org/ius-release.rpm
sudo yum install -y gcc python36u python36u-devel
cd /usr/bin
sudo ln -s python3.6 python3
sudo ln -s /usr/bin/python3 /usr/local/bin/python
python --version  # test python version
wget https://bootstrap.pypa.io/get-pip.py
sudo python3.6 get-pip.py
pip --version  # test pip is installed
pip install -U setuptools

# install Git
sudo yum -y install git2u

# INSTALL DOCKER ON CENTOS
#Remove OLD docker on centos:
sudo yum remove docker docker-common docker-selinux Docker-engine
# Install docker
sudo yum -y install yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce

# let users use docker without sudo
# https://docs.docker.com/engine/installation/linux/linux-postinstall
groups
#if previous command output didn’t have docker in the list of groups run this command: sudo groupadd docker
# now add users to docker group
sudo usermod -aG docker $USER
# start docker
sudo systemctl start docker
sudo systemctl enable docker  # to start docker on boot (add docker to autostart list)
sudo systemctl start docker  # start docker engine

docker run hello-world  # test that docker works

# install Jenkins on centos
# https://wiki.jenkins.io/display/JENKINS/Installing+Jenkins+on+Red+Hat+distributions
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum -y install jenkins
sudo usermod -aG docker jenkins  # let jenkins use docker without sudo

# start jenkins (other command options: stop/restart/status)
sudo service jenkins start

################
# Manual steps:
################
# go to your browser and load page http://localhost:8081

# retrieve initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# in the browser
# install desired plugins
