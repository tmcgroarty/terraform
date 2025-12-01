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

# Latest Ubuntu 22.04 in your region
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "jenkins_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  # This must be the **instance profile name**, not just the role name.
  iam_instance_profile   = var.iam_instance_profile

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
