# Data source for aws_ami 
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

# EC2 instance resource block
resource "aws_instance" "main-ec2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = data.terraform_remote_state.main-vpc.outputs.main-private-subnet[0].id
  associate_public_ip_address = false
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

