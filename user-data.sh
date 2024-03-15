#!bin/bash

export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY}"
export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_KEY}"
export AWS_DEFAULT_REGION="${AWS_REGION}"

sudo dnf update
sudo dnf install -y docker
sudo usermod -a -G docker ec2-user
newgrp docker

sudo systemctl start docker

docker volume create enron
docker network create enron

docker pull public.ecr.aws/zinclabs/zincsearch:latest
docker pull moisesmore75/mamuro:latest

docker container run -v enron:/data -e ZINC_DATA_PATH="/data" -dp 4080:4080 -e ZINC_FIRST_ADMIN_USER=admin -e ZINC_FIRST_ADMIN_PASSWORD=Complexpass#123 --name zincsearch public.ecr.aws/zinclabs/zincsearch:latest
docker container run -dp 3000:3000 --name mamuro-app moisesmore75/mamuro:latest

docker network connect enron mamuro-app
docker network connect enron zincsearch
