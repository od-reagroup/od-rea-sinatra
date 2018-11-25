#!/usr/bin/env bash
sudo yum update -y
sudo yum install docker git -y
sudo service docker start
sudo usermod -aG docker $USER
sudo su - $USER
mkdir od-rea
cd od-rea
git clone https://github.com/od-reagroup/od-rea-sinatra.git .
git clone https://github.com/rea-cruitment/simple-sinatra-app.git code
docker build -t odrea:latest .
docker run --name odrea --restart always -d -p 80:80 odrea

