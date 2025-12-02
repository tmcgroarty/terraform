terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
  # On your EC2 with jenkinsec2role attached, you do NOT need a profile here.
  # If you run locally with SSO, you could add: profile = "my-sso-profile"
}

# Latest Ubuntu 22.04 in your region (no longer used for ami, but harmless to keep)
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "jenkins_server" {
  ami                    = "ami-07233672216fff926"
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name
  iam_instance_profile   = var.iam_instance_profile

  # Ensure instance gets a public IP in your subnet
  associate_public_ip_address = true

  # Extra EBS data volume
  ebs_block_device {
    device_name           = "/dev/xvdq"  # shows up as /dev/xvdh on many Linux AMIs
    volume_size           = 430          # GB – change if you want bigger/smaller
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = var.instance_name
  }
}

output "instance_id" {
  value = aws_instance.jenkins_server.id
}

output "public_ip" {
  value = aws_instance.jenkins_server.public_ip
}
