#This remote data source is for main vpc and main-public0 id
data "terraform_remote_state" "main-vpc" {
  backend = "s3"

  config = {
    bucket = "main-backend-state-bucket"
    key    = "level1/terraform.tfstate"
    region = "us-east-1"
  }
}

# EC2 instance resource block
resource "aws_instance" "main-ec2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = data.terraform_remote_state.main-vpc.outputs.main-private-subnet[0].id
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.allow_ssh.id}"]
  key_name                    = var.key_name
  user_data                   = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install apache2 -y
  EOF

  tags = {
    Name = "main-ubuntu"
  }
}

