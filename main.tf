terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.21.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

locals {
  ami                    = "ami-08d4ac5b634553e16"
  instance_type          = "t2.micro"
  key_name               = "us-east-1-key"
}

resource "aws_instance" "build_server" {
  ami                    = local.ami
  instance_type          = local.instance_type
  key_name               = local.key_name
  vpc_security_group_ids = [aws_security_group.open_ports_22_8080.id]
  iam_instance_profile   = "aws-ec2-container_registry-access" # instance role with access to ECR

  tags = {
    Name = "Build Server"
  }

# wait fot ssh available on remote host
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("/home/ubuntu/keys/us-east-1-key.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'Build Server - SSH is UP!'",
    ]
  }

}

resource "aws_instance" "prod_server" {
  ami                    = local.ami
  instance_type          = local.instance_type
  key_name               = local.key_name
  vpc_security_group_ids = [aws_security_group.open_ports_22_8080.id]
  iam_instance_profile   = "aws-ec2-container_registry-access" # instance role with access to ECR

  tags = {
    Name = "Prod Server"
  }

# wait fot ssh available on remote host
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("/home/ubuntu/keys/us-east-1-key.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'Build Server - SSH is UP!'",
    ]
  }

}

resource "aws_security_group" "open_ports_22_8080" {
  name        = "allow_ports_22_and_8080"
  description = "Allow inbound traffic on ports 22 and 8080"

  ingress {
    description = "Open ssh port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Open port for tomcat"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ports_22_and_8080"
  }
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl",
    {
     build_server_ip = aws_instance.build_server.public_ip,
     prod_server_ip = aws_instance.prod_server.public_ip
    }
  )
  filename = "inventory"
}