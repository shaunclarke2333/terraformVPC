# public subnet ip addresses CIDR blocks
variable "public_subnet_cidr" {
  default = [
    "10.0.0.0/24",
    "10.0.1.0/24"
  ]
}
# private subnet ip addresses CIDR blocks
variable "private_subnet_cidr" {
  default = [
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}
