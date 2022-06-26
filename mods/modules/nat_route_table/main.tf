# Aws route table
resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_block
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = "${var.name}-routetable"
  }
}
