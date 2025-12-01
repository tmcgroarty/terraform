variable "region" {
  description = "AWS region"
  type        = string
}

variable "subnet_id" {
  description = "Subnet where EC2 will be launched"
  type        = string
}

variable "security_group_id" {
  description = "Security group for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "instance_name" {
  description = "Tag Name for the instance"
  type        = string
  default     = "jenkins-terraform-ec2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "iam_instance_profile" {
  description = "IAM instance profile name attached to EC2"
  type        = string
}
