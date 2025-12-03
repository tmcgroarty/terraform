provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2" {
  for_each = var.instances

  ami           = each.value.ami
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id

  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name
  iam_instance_profile   = var.iam_instance_profile

  associate_public_ip_address = each.value.associate_public_ip_address

  tags = {
    Name = each.key  # SFE, CFE, client, server
  }

  # Optional extra EBS volume (only for entries with ebs_size > 0)
  dynamic "ebs_block_device" {
    for_each = each.value.ebs_size > 0 ? [1] : []
    content {
      device_name = each.value.ebs_device_name
      volume_size = each.value.ebs_size
      volume_type = "gp3"
    }
  }
}
