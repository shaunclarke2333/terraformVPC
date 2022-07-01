
variable "subnet_group_name" {
  description = "variable input for the subnet group name"
}

variable "subnet_group_subnet_ids" {
  description = "variable input for subnet_group_subnet_ids"
}

variable "tag_db_subnet_group" {
  description = "variable input for the subnet group name"
}

variable "db_parameter_group_name" {
  description = "variable input for tag_db_subnet_group"
}

variable "db_parameter_group_family" {
  description = "variable input for db_parameter_group_family"
}

variable "sg_name" {
  description = "variable input for security group name"
}

variable "sg_description" {
  description = "variable input for security group description"
}

variable "sg_vpc_id" {
  description = "variable input for sg_vpc_id"
}

variable "sg_ingress_description" {
  description = "variable input for sg_ingress_description"
}

variable "sg_ingress_from_port" {
  description = "variable input for sg_ingress_from_port"
}

variable "sg_ingress_to_port" {
  description = "variable input for sg_ingress_to_port"
}

variable "sg_ingress_protocol" {
  description = "variable input for sg_ingress_protocol"
}

variable "sg_egress_from_port" {
  description = "variable input for sg_egress_from_port"
}

variable "sg_egress_to_port" {
  description = "variable input for sg_egress_to_port"
}

variable "sg_egress_protocol" {
  description = "variable input for sg_egress_protocol"
}

variable "sg_egress_cidr_blocks" {
  description = "variable input for sg_egress_cidr_blocks"
}

variable "sg_tag_name" {
  description = "variable input for sg_tag_name"
}

variable "allocated_storage" {
  description = "variable input for allocated_storage"
}

variable "storage_type" {
  description = "variable input for storage_type"
}

variable "engine" {
  description = "variable input for engine"
}

variable "engine_version" {
  description = "variable input for engine_version"
}

variable "instance_class" {
  description = "variable input for instance_class"
}

variable "db_port" {
  description = "variable input for db_port"
}

variable "rds_name" {
  description = "variable input for rds_name"
}

variable "rds_username" {
  description = "variable input for rds_username"
}

variable "parameter_group_name" {
  description = "variable input for parameter_group_name"
}

variable "skip_final_snapshot" {
  description = "variable input for skip_final_snapshot"
}

variable "multi_az" {
  description = "variable input for multi_az"
}

variable "vpc_security_group_ids" {
  description = "variable input for "
}

variable "backup_retention_period" {
  description = "variable input for "
}

variable "backup_window" {
  description = "variable input for "
}
