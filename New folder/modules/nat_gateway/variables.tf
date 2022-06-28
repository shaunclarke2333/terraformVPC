variable "allocation_id" {
  description = "elastic IP id variable input for nat gateway"
}

variable "subnet_id" {
  description = "IDs of subnets where nat gateway will be deployed"
}

variable "name" {
  description = "nat gateway tag name input"
}
