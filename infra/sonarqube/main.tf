terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Neuestes Ubuntu 24.04 LTS (Noble) AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  ssh_public_key = try(file(pathexpand(var.ssh_public_key_path)), null)

  cloud_init = templatefile("${path.module}/cloud-init.yml.tftpl", {
    sonar_db_user     = var.sonar_db_user
    sonar_db_password = var.sonar_db_password
  })
}

resource "aws_key_pair" "sonarqube" {
  count      = local.ssh_public_key != null ? 1 : 0
  key_name   = "${var.project_name}-key"
  public_key = trimspace(local.ssh_public_key)

  tags = {
    Name = "${var.project_name}-keypair"
  }
}

resource "aws_security_group" "sonarqube" {
  name        = "${var.project_name}-sg"
  description = "Security group for the SonarQube server (${var.project_name})"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    description = "SonarQube web UI"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = [var.allowed_web_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}

resource "aws_instance" "sonarqube" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type # SonarQube braucht min. 8 GB RAM
  vpc_security_group_ids      = [aws_security_group.sonarqube.id]
  key_name                    = local.ssh_public_key != null ? aws_key_pair.sonarqube[0].key_name : null
  user_data                   = base64encode(local.cloud_init)
  user_data_replace_on_change = true

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 30
    delete_on_termination = true
  }

  tags = {
    Name = var.project_name
  }
}

resource "aws_eip" "sonarqube" {
  instance = aws_instance.sonarqube.id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-eip"
  }
}
