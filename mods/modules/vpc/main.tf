# aws vpc module 
resource "aws_vpc" "my-main-vpc" {
  cidr_block = var.cidr_block

  tags = {
    "Name" = "${var.name}-vpc"
  }
}
