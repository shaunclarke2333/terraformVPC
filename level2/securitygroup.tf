# Security group for the main-ec2 instance to allow ssh inbound on port 22
resource "aws_security_group" "allow_ssh" {
  name        = "ec2-instance"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.main-vpc.outputs.main-vpc-id

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

# Security group for the main-loab-balancer Allow port 80 TCP inbound to ELB
resource "aws_security_group" "main-elb-tcp80" {
  name        = "load-balancer"
  description = "Allow port 80 TCP inbound to ELB"
  vpc_id      = data.terraform_remote_state.main-vpc.outputs.main-vpc-id

  ingress {
    description = "http to ELB"
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
    Name = "main-elb-tcp80"
  }
}
