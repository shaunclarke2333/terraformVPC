#Security group for this EC2 instance to allow ssh inbound on port 22
resource "aws_security_group" "allow_ssh" {
  name        = "ec2-instance"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.my-main-vpc.id

  ingress {
    description      = "ssh to VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main-allows-ssh"
  }
}

#EC2 instance resource block
resource "aws_instance" "main-ubuntu-ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = [ aws_security_group.allow_ssh.id ]
  key_name = var.key_name

  tags = {
    Name = var.name
  }
}
