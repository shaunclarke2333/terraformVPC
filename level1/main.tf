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
  source = "../modules/vpc"

  # my_vpc aws vpc resource 
  vpc_cidr_block = "10.0.0.0/16"
  vpc_tag_name   = "main"

  #list of public subnet cidr block ip
  public_subnet_cidr = var.public_subnet_cidr

  #list of public subnet cidr block ip
  private_subnet_cidr = var.private_subnet_cidr

  # Public subnets in my-main-vpc
  public_availability_zone = data.aws_availability_zones.available.names
  public_subnet_cidr_block = var.public_subnet_cidr
  public_subnet_tag_name   = "main-public"

  # Private subnets in my-main-vpc
  private_availability_zone = data.aws_availability_zones.available.names
  private_subnet_cidr_block = var.private_subnet_cidr
  private_subnet_tag_name   = "main-private"

  # Internet gateway to allow public subents to access the internet
  tag_ig_name = "main"

  # Elastic IP for NAT gateway
  tag_eip_name = "main"

  # NAT gateway to allow private subnet to communicate with the internet
  tag_nat_name = "main"

  # Public route table to route to the internet gateway
  public_route_table_cidr_block = "0.0.0.0/0"
  tag_pub_route_table_name      = "main"

  # Private route table to route to the NAT gateway
  private_route_table_cidr_block = "0.0.0.0/0"
  tag_pvt_route_table_name       = "main"

  # Security group for the main-loab-balancer Allow port 80 TCP inbound to ELB
  sg_name        = "main-security-group"
  sg_description = "Allow port 80 TCP inbound"

  #ingress
  sg_ingress_description = "http to ELB"
  sg_ingress_from_port   = 80
  sg_ingress_to_port     = 80
  sg_ingress_protocol    = "tcp"
  sg_ingress_cidr_blocks = ["0.0.0.0/0"]

  #egress
  sg_egress_from_port   = 0
  sg_egress_to_port     = 65535
  sg_egress_protocol    = "tcp"
  sg_egress_cidr_blocks = ["0.0.0.0/0"]

  #tags
  sg_tag_name = "main"
}
