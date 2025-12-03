variable "region" {
  type    = string
  default = "us-east-2"
}

variable "key_name" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "iam_instance_profile" {
  type = string
}

variable "instances" {
  description = "EC2 instances to create"
  type = map(object({
    ami                         = string
    subnet_id                   = string
    instance_type               = string
    associate_public_ip_address = bool
    ebs_size                    = number   # use 0 if not required
    ebs_device_name             = string   # empty string if not required
  }))
}
