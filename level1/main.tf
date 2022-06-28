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

#Declaring availability zone data source
data "aws_availability_zones" "available" {
  state = "available"
}

# Complete VPC deployment from VPC module
module "main-vpc" {
  count = length(var.public_subnet_cidr)

  source = "../modules/vpc"

  # my_vpc aws vpc resource 
  vpc_cidr_block = "10.0.0.0/16"
  vpc_tag_name = "main"

  # Public subnets in my-main-vpc
  public_availability_zone = data.aws_availability_zones.available.names[count.index]


  
}