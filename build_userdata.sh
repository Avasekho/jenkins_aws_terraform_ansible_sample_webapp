#!/bin/bash
sudo apt update -y
sudo apt install -y maven default-jdk awscli python3-pip docker.io docker-compose
sudo usermod -a -G docker ubuntu