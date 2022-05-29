# Terraform block with required provider and terraform version listed
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.27"
    }
  }
  required_version = ">=0.14.9"
}

# Provider block with region defined
provider "aws" {
    region = "us-east-1"
}

# my_vpc aws vpc resource 
resource "aws_vpc" "my-main-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "my-main-vpc"
  }
}

# Public subnets in my-main-vpc
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my-main-vpc.id
  cidr_block = var.public_subnet_cidr[count.index]

  tags = {
    Name = "public_subnet_${count.index}"
  }

  count = 2
}

# Private subnets in my-main-vpc
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my-main-vpc.id
  cidr_block = var.private_subnet_cidr[count.index]

  tags = {
    Name = "private_subnet_${count.index}"
  }

  count = 2
}

# Internet gateway to allow public subents to access the internet
resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my-main-vpc.id

  tags = {
    Name = "my_internet_gateway"
  }
}

# Elastic IP for NAT gateway
resource "aws_eip" "nat" {
  vpc = true

  count = 2
}

# NAT gateway to allow private subnet to communicate with the internet
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id

  tags = {
    Name = "NATGateWay"
  }

  count = 2
}

# Public route table to route to the internet gateway
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my-main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }

  tags = {
    Name = "public_route_table"
  }
}

# Associating public route table with public subnets
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
  count = 2
}

# Private route table to route to the NAT gateway
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my-main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }

  tags = {
    Name = "private_route_table_${count.index}"
  }
  count = 2
}


# Associating private route table with private subnets
resource "aws_route_table_association" "pvt-main" {
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
  count = 2
}
