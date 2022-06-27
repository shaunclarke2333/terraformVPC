# Autoscaling group using the main-launch-temp template
resource "aws_autoscaling_group" "main-autoscaling-group" {
  name                      = var.asg_name
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  health_check_grace_period = var.asg_health_check_grace_period
  health_check_type         = var.asg_health_check_type
  desired_capacity          = var.asg_desired_capacity
  force_delete              = var.asg_force_delete
  vpc_zone_identifier       = var.asg_vpc_zone_identifier
  target_group_arns         = var.asg_target_group_arns

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  tag {
    key                 = var.tag_key
    value               = "${var.tag_value}-autoscaling-group"
    propagate_at_launch = var.propagate_at_launch
  }
}
