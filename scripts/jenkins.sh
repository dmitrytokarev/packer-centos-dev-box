#!/usr/bin/env bash

set -x # print commands
set -e # fail script on a first failed command

# update system
sudo yum update -y

# install Java (OpenJDK)
sudo yum -y install java

# install Python 3
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y https://centos7.iuscommunity.org/ius-release.rpm
# sudo yum install -y gcc python36u python36u-devel
sudo yum install -y gcc python36 python36-devel --skip-broken # from epel repo
# optionally https://tecadmin.net/install-python-3-7-on-centos
# cd /usr/bin
# sudo ln -s python3.6 python3
# sudo ln -s /usr/bin/python3 /usr/local/bin/python
python3 --version  # test python version
sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
pip3 --version  # test pip is installed
pip3 install -U setuptools pip

# install Git
sudo yum -y install git2u

# INSTALL DOCKER ON CENTOS
#Remove OLD docker on centos:
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
# Install docker
sudo yum -y install yum-utils device-mapper-persistent-data lvm2 --skip-broken
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum-config-manager --disable docker-ce-nightly

# the following fails on CentOS 7.4
#sudo yum install docker-ce docker-ce-cli containerd.io --skip-broken

# this worked on CentOS 7.4
# looks like Docker quietly stopped supporting CentOS/RHEL:
# https://github.com/docker/for-linux/issues/299
# https://github.com/docker/for-linux/issues/20
# https://github.com/docker/docker.github.io/issues/3818
sudo yum -y install docker-ce-18.09.8-3

# let users use docker without sudo
# https://docs.docker.com/engine/installation/linux/linux-postinstall
groups
#if previous command output didn’t have docker in the list of groups run this command: sudo groupadd docker
# now add users to docker group
sudo usermod -aG docker default
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
#sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# in the browser
# install desired plugins
