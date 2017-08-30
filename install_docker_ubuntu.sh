#!/usr/bin/env bash

set -e

DOCKER_REPO="stable"  # choices: stable, edge, test
ARCH="amd64"  # choices: amd64, armhf, s390x

DOCEKR_VERSION=""  # install latest if empty
DOCKER_COMPOSE_VERSION="1.15.0"  # don't install if empty
#DOCKER_MACHINE_VERSION="0.8.2"
#VIRTUALBOX_VERSION="5.1.10"


echo "**************** Clean the environment. ****************"
sudo apt-get remove docker docker-engine docker.io

echo
echo "**************** Make sure the prerequisites. ****************"
sudo apt-get update
sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common

echo
echo "**************** Prepare docker's apt repo. ****************"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=$ARCH] https://download.docker.com/linux/ubuntu $(lsb_release -cs) $DOCKER_REPO"
sudo apt-get update


#echo
#echo "**************** Available docker versions. ****************"
#apt-cache madison docker-ce


echo
echo "**************** Install docker. ****************"
sudo apt-get install docker-ce=${DOCEKR_VERSION}

echo
echo "**************** Enable non-root user privilege. ****************"
sudo groupadd docker
sudo usermod -aG docker $(whoami)


if [[ -n ${DOCKER_COMPOSE_VERSION} ]]; then
    echo
    echo "**************** Install docker-compose. ****************"
    sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod a+x /usr/local/bin/docker-compose
    sudo curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
fi

if [[ -n ${DOCKER_MACHINE_VERSION} ]]; then
    echo
    echo "**************** Install docker-machine. ****************"
    sudo curl -L "https://github.com/docker/machine/releases/download/v${DOCKER_MACHINE_VERSION}/docker-machine-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-machine
    sudo chmod a+x /usr/local/bin/docker-machine
fi

if [[ -n ${VIRTUALBOX_VERSION} ]]; then
    echo
    echo "**************** Install virtualbox. ****************"
    echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
    curl -L https://www.virtualbox.org/download/oracle_vbox.asc -o $HOME/oracle_vbox.asc
    sudo apt-key add $HOME/oracle_vbox.asc
    rm -f $HOME/oracle_vbox.asc
    sudo apt-get update
    sudo apt-get -y install virtualbox-${VIRTUALBOX_VERSION}
fi

echo
echo "**************** Installation complete. ****************"
