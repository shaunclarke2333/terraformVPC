
variable "sg_name" {
  description = "input variable for security group name "
}

variable "sg_description" {
  description = "input variable for security group description"
}

variable "vpc_id" {
  description = "input variable for vpc id the security group will use"
}

variable "sg_ingress_description" {
  description = "input variable for security group ingress description"
}

variable "sg_ingress_from_port" {
  description = "input variable for security group ingress from port"
}

variable "sg_ingress_to_port" {
  description = "input variable for security group ingress to port"
}

variable "sg_ingress_protocol" {
  description = "input variable for security group ingress protocol"
}

variable "sg_ingress_cidr_blocks" {
  description = "input variable for security group ingress cidr block"
}

variable "sg_egress_from_port" {
  description = "input variable for security group egress from port"
}

variable "sg_egress_to_port" {
  description = "input variable for security group egress to port"
}

variable "sg_egress_protocol" {
  description = "input variable for security group egress protocol"
}

variable "sg_egress_cidr_blocks" {
  description = "input variable for security group egress cidr blocks"
}

variable "sg_tag_name" {
  description = "input variable for security group tag name"
}
