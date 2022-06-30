variable "sg_name" {
  description = "input variable for security group name "
}

variable "sg_description" {
  description = "input variable for security group description"
}

variable "sg_vpc_id" {
  description = "input variable for security group vpc id"
}

variable "sg_443_ingress_description" {
  description = "input variable for security group 443 ingress  description"
}

variable "sg_443_ingress_from_port" {
  description = "input variable for security group 443 ingress  from port"
}

variable "sg_443_ingress_to_port" {
  description = "input variable for security group 443 ingress  to port"
}

variable "sg_443_ingress_protocol" {
  description = "input variable for security group 443 ingress  protocol"
}

variable "sg_443_ingress_cidr_blocks" {
  description = "input variable for security group 443 ingress  cidr block"
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

variable "load_balancer_name" {
  description = "input variable for load balancer name"
}

variable "load_balancer_internal" {
  description = "input variable for load balancer internal"
}

variable "load_balancer_type" {
  description = "input variable for load balancer type"
}

variable "subnets" {
  description = "input variable for load balancer subnets"
}

variable "name_tag" {
  description = "input variable for load balancer tag name = ..."
}

variable "target_group_name" {
  description = "input variable for target group name"
}

variable "target_group_port" {
  description = "input variable for target group port"
}

variable "target_group_protocol" {
  description = "input variable for target group protocol"
}

variable "vpc_id" {
  description = "input variable for vpc id that target group will use"
}

variable "health_check_enabled" {
  description = "input variable for health check enabled"
}

variable "health_check_path" {
  description = "input variable for health check path"
}

variable "health_check_port" {
  description = "input variable for health check port"
}

variable "health_check_healthy_threshold" {
  description = "input variable for healthy threshold in the healthcheck block"
}

variable "health_check_unhealthy_threshold" {
  description = "input variable unhealthy threshold in the health check block"
}

variable "health_check_timeout" {
  description = "input variable for health check timeout"
}

variable "health_check_interval" {
  description = "input variable for health check interval"
}

variable "health_check_mathcer" {
  description = "input variable for health check matcher"
}

variable "load_balancer_arn" {
  description = "input variable for load_balancer_arn"
}

variable "listener_port" {
  description = "input variable for load balancer listener port"
}

variable "listener_protocol" {
  description = "input variable for load balancer listener protocol"
}

variable "certificate_arn" {
  description = "input variable for load balancer certificate_arn"
}

variable "ssl_policy" {
  description = "input variable for load balancer listener 443 ssl_policy"
}

variable "listener_defualt_action_type" {
  description = "input variable for load balancer listener default action type"
}

