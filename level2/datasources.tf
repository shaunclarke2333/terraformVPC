#This remote data source is for main vpc and main-public0 id
data "terraform_remote_state" "level1-main-vpc" {
  backend = "s3"

  config = {
    bucket = "main-backend-state-bucket"
    key    = "level1/terraform.tfstate"
    region = "us-east-1"
  }
}

# Data source for ubuntu aws_ami 
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["aws-marketplace"]
}

#Data source policy for Amazon EC2 Role to enable AWS Systems Manager service core functionality
data "aws_iam_policy" "session-mamanger-policy" {
  name = "AmazonSSMManagedInstanceCore"
}
