#!/bin/bash

sudo apt update
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev -y
curl -O https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tar.xz
tar -xf Python-3.8.12.tar.xz
cd Python-3.8.12
./configure --enable-optimizations
make -j 4
sudo make altinstall
python3.8 --version
pip3.8 --version
cd ..
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo docker run hello-world
sudo apt-get install software-properties-common -y
sudo apt-get update
sudo apt install default-jdk -y
sudo apt-get update -y
sudo apt-get install -y gnuplot
ls /bin/gnuplot
sudo apt install nodejs -y
node -v
pip3.8 install jupyterlab 
pip3.8 install kotlin-jupyter-kernel
