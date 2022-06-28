# Terraform block with required provider and terraform version listed
terraform {
  required_version = ">=0.14.9"
}

# Elastic IP module
resource "aws_eip" "elastic-ip" {
  vpc = true

  tags = {
    "Name" = "${var.name}-eip"
  }
}
