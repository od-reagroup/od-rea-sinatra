#!/usr/bin/env bash
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
sudo DEBIAN_FRONTEND=noninteractive apt-get remove docker docker-engine docker.io -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo DEBIAN_FRONTEND=noninteractive add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install docker-ce docker-compose git -y
sudo usermod -aG docker $USER
sudo su - $USER
mkdir od-rea
cd od-rea
git clone https://github.com/od-reagroup/od-rea-sinatra.git .
git clone https://github.com/rea-cruitment/simple-sinatra-app.git code
docker-compose up -d
