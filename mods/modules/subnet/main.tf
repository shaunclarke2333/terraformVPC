# Terraform block with required provider and terraform version listed
terraform {
  required_version = ">=0.14.9"
}

# Subnet module
resource "aws_subnet" "main_subnet" {
  availability_zone = var.availability_zone
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr

  tags = {
    Name = "${var.name}-subnet"
  }
}
