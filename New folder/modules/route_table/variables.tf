variable "vpc_id" {
  description = "input variable for route table vpc_id field"
  type = string
}

variable "cidr_block" {
  description = "input variable for route table cidr_block"
  type = string
}

variable "gateway_id" {
  description = "input variable for route table gateway_id field"
  type = string
}

variable "rt_tag_name" {
  description = "input variable for route table tag name field"
  type = string
}
