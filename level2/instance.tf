# Data source for main vpc id for security group
data "aws_vpc" "my-main-vpc" {
  id = var.vpcid
}

# Security group for this EC2 instance to allow ssh inbound on port 22
resource "aws_security_group" "allow_ssh" {
  name        = "ec2-instance"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.my-main-vpc.id

  ingress {
    description = "ssh to VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["70.95.138.224/32"]

  }
  ingress {
    description = "http to VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main-allows-ssh"
  }
}
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

# Data source for public subnet
data "aws_subnet" "public_subnet" {
  id = var.subnetid
} 

# EC2 instance resource block
resource "aws_instance" "main-ec2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.public_subnet.id
  associate_public_ip_address = true
  security_groups             = ["${aws_security_group.allow_ssh.id}"]
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

