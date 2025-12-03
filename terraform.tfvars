region              = "us-east-2"
key_name            = "OHIO"
security_group_ids  = ["sg-0175e04816330889a"]
iam_instance_profile = "JenkinsEC2Role"

instances = {
  SFE = {
    ami                         = "ami-07233672216fff926"
    subnet_id                   = "subnet-0b67c2aa1af191b9e"
    instance_type               = "m5.large"
    associate_public_ip_address = true
    ebs_size                    = 430
    ebs_device_name             = "/dev/xvdq"
  }

  CFE = {
    ami                         = "ami-07233672216fff926"
    subnet_id                   = "subnet-04a06f9b575bf2083"
    instance_type               = "m5.large"
    associate_public_ip_address = true
    ebs_size                    = 430
    ebs_device_name             = "/dev/xvdq"
  }

  client = {
    ami                         = "ami-0f5fcdfbd140e4ab7"
    subnet_id                   = "subnet-082af55811c6ae426"
    instance_type               = "t3.large"
    associate_public_ip_address = true
    ebs_size                    = 0
    ebs_device_name             = ""
  }

  server = {
    ami                         = "ami-0f5fcdfbd140e4ab7"
    subnet_id                   = "subnet-0a6338b1259311ef9"
    instance_type               = "t3.large"
    associate_public_ip_address = true
    ebs_size                    = 0
    ebs_device_name             = ""
  }
}
