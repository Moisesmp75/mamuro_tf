terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

data "template_file" "ec2ud" {
  template = file("user-data.sh")
    vars = {
    AWS_ACCESS_KEY = var.aws_access_key
    AWS_SECRET_KEY = var.aws_secret_key
    AWS_REGION     = var.aws_region
  }
}

resource "tls_private_key" "mamuro_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "private_key" {
  content  = tls_private_key.mamuro_key.private_key_pem
  filename = "mamuro_key.pem"
}

resource "aws_key_pair" "mamuro_key_pair" {
  key_name = "mamuro_key"
  public_key = tls_private_key.mamuro_key.public_key_openssh
}

resource "aws_security_group" "mamuro" {
  name        = "zincsearch_api"
  description = "Allow inbound traffic on ports 4080 and 3000 from anywhere"

  ingress {
    from_port   = 4080
    to_port     = 4080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mamuro_api" {
  ami                    = "ami-052c9ea013e6e3567"
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.mamuro_key_pair.key_name
  user_data              = data.template_file.ec2ud.rendered
  vpc_security_group_ids = [aws_security_group.mamuro.id]
  
  tags = {
    Name = var.instance_name
  }
}