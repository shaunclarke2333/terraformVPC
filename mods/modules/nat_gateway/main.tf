# NAT gateway to allow private subnet to communicate with the internet
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = var.allocation_id
  subnet_id     = var.subnet_id

  tags = {
    Name = "${var.name}-nat-gateway"
  }
}
