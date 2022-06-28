variable "asg_name" {
  description = "input variable for autoscaliong group name"
}

variable "asg_max_size" {
  description = "input variable for autoscaliong group max size"
}

variable "asg_min_size" {
  description = "input variable for autoscaliong group "
}

variable "asg_health_check_grace_period" {
  description = "input variable for autoscaliong group health check grace period"
}

variable "asg_health_check_type" {
  description = "input variable for autoscaliong group health check type"
}

variable "asg_desired_capacity" {
  description = "input variable for autoscaliong group desired capacity"
}

variable "asg_force_delete" {
  description = "input variable for autoscaliong group force delete"
}

variable "asg_vpc_zone_identifier" {
  description = "input variable for autoscaliong group "
}

variable "asg_target_group_arns" {
  description = "input variable for autoscaliong group target group arns"
}

variable "launch_template_id" {
  description = "input variable for autoscaliong group launch template id"
}

variable "launch_template_version" {
  description = "input variable for autoscaliong group launch template version"
}

variable "tag_key" {
  description = "input variable for autoscaliong group tag key"
}

variable "tag_value" {
  description = "input variable for autoscaliong group tag_value"
}

variable "propagate_at_launch" {
  description = "input variable for autoscaliong group tag propagate at launch"
}
