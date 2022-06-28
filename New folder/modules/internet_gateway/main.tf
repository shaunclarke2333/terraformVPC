# Internet gateway to allow public subents to access the internet
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-ig"
  }
}
