
variable "policy_name" {
  description = "input variable for name of iam role policy"
}

variable "policy" {
  description = "input variable for the policy of iam role policy"
}

variable "role_name" {
  description = "input variable for the iam role name"
}

variable "assume_role_policy_version" {
  description = "input variable for the iam role assume role policy version"
}

variable "assume_role_policy_action" {
  description = "input variable for the iam role assume role policy action"
}

variable "assume_role_policy_effect" {
  description = "input variable for the iam role assume role policy effect"
}

variable "assume_role_policy_principal_service" {
  description = "input variable for the iam role assume role policy principal service"
}

variable "assume_role_policy_tag_name" {
  description = "input variable for the iam role tag name"
}

variable "iam_instance_profile_name" {
  description = "input variable for instance profile name"
}

variable "launch_template_name" {
  description = "input variable for the launch template name"
}

variable "launch_template_image_id" {
  description = "input variable for the launch template image id"
}

variable "launch_template_instance_type" {
  description = "input variable for the launch template instance type"
}

variable "user_data" {
  description = "input variable for the user data"
}

variable "vpc_security_group_ids" {
  description = "input variable for the VPC security group ids"
}

variable "resource_type" {
  description = "input variable for the resource type"
}

variable "tag_name" {
  description = "input variable for the tag name"
}

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
