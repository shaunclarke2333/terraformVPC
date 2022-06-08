# Terraform block with required provider and terraform version listed
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
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
    "Name" = "main-vpc"
  }
}

#Output for main-vpc id
output "main-vpc-id" {
  description = "will be used by devices that depend on the vpc ID"
  value       = aws_vpc.my-main-vpc.id
}

#Declaring availability zone data source
data "aws_availability_zones" "available" {
  state = "available"
}

# Public subnets in my-main-vpc
resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidr)

  availability_zone = data.aws_availability_zones.available.names[count.index]

  vpc_id     = aws_vpc.my-main-vpc.id
  cidr_block = var.public_subnet_cidr[count.index]

  tags = {
    Name = "main-public${count.index}"
  }
}

# Output for main-public0 subnet id
output "main-public0-subnet" {
  description = "will be used by devices that depend on main-public0 subnet ID"
  value       = aws_subnet.public_subnet[0].id
}

# Private subnets in my-main-vpc
resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidr)

  availability_zone = data.aws_availability_zones.available.names[count.index]

  vpc_id     = aws_vpc.my-main-vpc.id
  cidr_block = var.private_subnet_cidr[count.index]

  tags = {
    Name = "main-private${count.index}"
  }
}

# Internet gateway to allow public subents to access the internet
resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my-main-vpc.id

  tags = {
    Name = "main-internet-gateway"
  }
}

# Elastic IP for NAT gateway
resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidr)

  vpc = true

  tags = {
    "Name" = "main-nat${count.index}"
  }
}

# NAT gateway to allow private subnet to communicate with the internet
resource "aws_nat_gateway" "nat_gateway" {
  count = length(var.public_subnet_cidr)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id

  tags = {
    Name = "main-nat${count.index}"
  }
}

# Public route table to route to the internet gateway
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my-main-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }

  tags = {
    Name = "main-public"
  }
}

# Associating public route table with public subnets
resource "aws_route_table_association" "main" {
  count = length(var.public_subnet_cidr)

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# Private route table to route to the NAT gateway
resource "aws_route_table" "private_route_table" {
  count = length(var.private_subnet_cidr)

  vpc_id = aws_vpc.my-main-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }

  tags = {
    Name = "main-private${count.index}"
  }
}


# Associating private route table with private subnets
resource "aws_route_table_association" "pvt-main" {
  count = length(var.private_subnet_cidr)

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}
