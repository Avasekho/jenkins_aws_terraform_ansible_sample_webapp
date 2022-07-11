#!/bin/bash
sudo apt update
sudo apt install -y docker.io docker-compose awscli
sudo usermod -a -G docker ubuntu