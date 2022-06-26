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
module "my-main-vpc" {
  source     = "../mods/modules/vpc"
  cidr_block = "10.0.0.0/16"

  name = "main"
}

#Declaring availability zone data source
data "aws_availability_zones" "available" {
  state = "available"
}

# Public subnets in my-main-vpc
module "main_public_subnet" {
  count = length(var.public_subnet_cidr)

  source            = "../mods/modules/subnet"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = module.my-main-vpc.main-vpc-id
  subnet_cidr         = var.public_subnet_cidr[count.index]

  name = "${count.index}main-public"
}

# private subnets in my-main-vpc
module "main_private_subnet" {
  count = length(var.private_subnet_cidr)

  source            = "../mods/modules/subnet"
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = module.my-main-vpc.main-vpc-id
  subnet_cidr         = var.private_subnet_cidr[count.index]
  name = "${count.index}-main-private"
 
}

# Internet gateway to allow public subents to access the internet
module "my_internet_gateway" {
  source = "../mods/modules/internet_gateway"
  vpc_id = module.my-main-vpc.main-vpc-id

  name = "main"
}

# Elastic IP for NAT gateway
module "main_elastic_ip" {
  count = length(var.public_subnet_cidr)

  source = "../mods/modules/elastic_ip"

  name = "${count.index}-main"
}

# NAT gateway to allow private subnet to communicate with the internet
module "main_nat_gateway" {
  count = length(var.public_subnet_cidr)

  source        = "../mods/modules/nat_gateway"
  allocation_id = module.main_elastic_ip[count.index].eip_output.id
  subnet_id     = module.main_public_subnet[count.index].subnet.id

  name = "${count.index}-main"
}

# Public route table to route to the internet gateway
module "main_public_route_table" {
  source = "../mods/modules/route_table"
  vpc_id = module.my-main-vpc.main-vpc-id
  cidr_block = "0.0.0.0/0"
  gateway_id = module.my_internet_gateway.internet_gateway_id


  name = "public"
}

# Associating public route table with public subnets
module "main_public_route_table_association" {
  count = length(var.public_subnet_cidr)

  source         = "../mods/modules/route_table_association"
  subnet_id      = module.main_public_subnet[count.index].subnet.id
  route_table_id = module.main_public_route_table.route-table-id

}

# Private route table to route to the NAT gateway
module "main_private_route_table" {
  count = length(var.private_subnet_cidr)

  source = "../mods/modules/nat_route_table"
  vpc_id = module.my-main-vpc.main-vpc-id
  cidr_block     = "0.0.0.0/0"
  nat_gateway_id = module.main_nat_gateway[count.index].nat_gateway_output.id


  name = "${count.index}-private"
}

# Associating private route table with private subnets
module "main_private_route_table_association" {
  count = length(var.private_subnet_cidr)

  source         = "../mods/modules/route_table_association"
  subnet_id      = module.main_private_subnet[count.index].subnet.id
  route_table_id = module.main_private_route_table[count.index].route-table-id

}





