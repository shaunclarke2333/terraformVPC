# public subnet ip addresses CIDR blocks
variable "public_subnet_cidr" {
  description = "public subnet ip addresses CIDR blocks"
  default = [
    "10.0.0.0/24",
    "10.0.1.0/24"
  ]
}
# private subnet ip addresses CIDR blocks
variable "private_subnet_cidr" {
  description = "private subnet ip addresses CIDR blocks"
  default = [
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}
# instance type for ec2
variable "instance_type" {
  description = "instance type for ec2"
  default     = "t2.small"
}

# key to connect to ec2
variable "key_name" {
  description = "key to connect to main-ec2 resource"
  default     = "main"

}
