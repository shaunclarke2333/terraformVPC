variable "vpc_cidr_block" {
  type        = string
  description = "This will be used as the input for the VPC cider block"
}

variable "vpc_tag_name" {
  type        = string
  description = "This will be used as the input for the VPC name"
}

variable "public_subnet_cidr" {
  description = "varible for public subnet_cidr for count input"
}

variable "private_subnet_cidr" {
  description = "varible for private subnet_cidr for count input"
}

variable "public_availability_zone" {
  description = "varible for public availability zone input"
}

variable "private_availability_zone" {
  description = "varible for private subnet availability zone input"
}

variable "public_subnet_cidr_block" {
  description = "varible for public subnet_cidr block input"
}

variable "private_subnet_cidr_block" {
  description = "varible for public subnet_cidr block input"
}

variable "public_subnet_tag_name" {
  description = "varible for public subnet name tag input"
}

variable "private_subnet_tag_name" {
  description = "varible for private subnet name tag input"
}

variable "tag_ig_name" {
  description = " internet gateway tag name variable input"
}

variable "tag_eip_name" {
  description = "elastic ip name tag variable input"
}

variable "tag_nat_name" {
  description = "nat gateway tag variable input"
}

variable "public_route_table_cidr_block" {
  description = "public route table cidr block variable input"
}

variable "tag_pub_route_table_name" {
  description = "tag route table name variable input"
}

variable "private_route_table_cidr_block" {
  description = "private route table cidr variable input"
}

variable "tag_pvt_route_table_name" {
  description = "tag route table name variable input"
}
