
# my_vpc aws vpc resource 
resource "aws_vpc" "my-main-vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    "Name" = "${var.vpc_tag_name}-vpc"
  }
}

# Public subnets in my-main-vpc
resource "aws_subnet" "public_subnet" {
  availability_zone = var.public_availability_zone
  vpc_id     = aws_vpc.my-main-vpc.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "${var.public_subnet_tag_name}-subnet"
  }
}

# Private subnets in my-main-vpc
resource "aws_subnet" "private_subnet" {
  availability_zone = var.private_availability_zone
  vpc_id     = aws_vpc.my-main-vpc.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "${var.private_subnet_tag_name}-subnet"
  }
}

# Internet gateway to allow public subents to access the internet
resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my-main-vpc.id

  tags = {
    Name = "${var.tag_ig_name}-internet-gateway"
  }
}

# Elastic IP for NAT gateway
resource "aws_eip" "nat" {
  vpc = true

  tags = {
    "Name" = "${var.tag_eip_name}-elastic-ip"
  }
}


# NAT gateway to allow private subnet to communicate with the internet
resource "aws_nat_gateway" "nat_gateway" {
  count = length(var.public_subnet_cidr)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id

  tags = {
    Name = "${var.tag_nat_name}-nat-gateway-${count.index}"
  }
}

# Public route table to route to the internet gateway
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my-main-vpc.id

  route {
    cidr_block = var.public_route_table_cidr_block
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }

  tags = {
    Name = "${var.tag_pub_route_table_name}-public-route-table"
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
    cidr_block     = var.private_route_table_cidr_block
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }

  tags = {
    Name = "${var.tag_pvt_route_table_name}-private-route-table-${count.index}"
  }
}


# Associating private route table with private subnets
resource "aws_route_table_association" "pvt-main" {
  count = length(var.private_subnet_cidr)

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}

# Security group for the main-loab-balancer Allow port 80 TCP inbound to ELB
resource "aws_security_group" "main-elb-tcp80" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = aws_vpc.my-main-vpc.id

  ingress {
    description = var.sg_ingress_description
    from_port   = var.sg_ingress_from_port
    to_port     = var.sg_ingress_to_port
    protocol    = var.sg_ingress_protocol
    cidr_blocks = var.sg_ingress_cidr_blocks
  }

  egress {
    from_port   = var.sg_egress_from_port
    to_port     = var.sg_egress_to_port
    protocol    = var.sg_egress_protocol
    cidr_blocks = var.sg_egress_cidr_blocks
  }

  tags = {
    Name = "${var.sg_tag_name}-sg"
  }
}
