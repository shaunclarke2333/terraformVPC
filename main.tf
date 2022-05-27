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

# # Private subnets in my-main-vpc
# resource "aws_subnet" "private_subnet" {
#   vpc_id     = aws_vpc.my-main-vpc.id
#   cidr_block = var.private_subnet_cidr[count.index]

#   tags = {
#     Name = "private_subnet_${count.index}"
#   }

#   count = 2
# }
