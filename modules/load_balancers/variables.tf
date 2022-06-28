variable "load_balancer_name" {
  description = "input variable for load balancer name"
}

variable "load_balancer_internal" {
  description = "input variable for load balancer internal"
}

variable "load_balancer_type" {
  description = "input variable for load balancer type"
}

variable "security_groups" {
  description = "input variable for load balancer security groups"
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

variable "listener_defualt_action_type" {
  description = "input variable for load balancer listener default action type"
}

variable "target_group_arn" {
  description = "input variable for load balancer target_group_arn"
}
