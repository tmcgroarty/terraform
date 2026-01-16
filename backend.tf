terraform {
  backend "local" {
    path = "/var/lib/jenkins/terraform-state/ec2-pipeline.tfstage"
    }
  }
