# Security group for this EC2 instance to allow ssh inbound on port 22
resource "aws_security_group" "allow_ssh" {
  name        = "ec2-instance"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.my-main-vpc.id

  ingress {
    description = "ssh to VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["70.95.138.224/32"]

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


# EC2 instance resource block
resource "aws_instance" "main-ec2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet[0].id
  associate_public_ip_address = true
  security_groups             = ["${aws_security_group.allow_ssh.id}"]
  key_name                    = var.key_name

  tags = {
    Name = "main-ubuntu"
  }
}
