# Autoscaling group using the main-launch-temp template
resource "aws_autoscaling_group" "main-autoscaling-group" {
  name                      = "main-autoscaling-group"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 200
  health_check_type         = "EC2"
  desired_capacity          = 4
  force_delete              = true
  vpc_zone_identifier       = [for subnet in data.terraform_remote_state.level1-main-vpc.outputs.main-private-subnet : subnet.id]
  target_group_arns         = [aws_lb_target_group.main-target-group.arn]

  launch_template {
    id      = aws_launch_template.main-launch-temp.id
    version = "$Latest"
  }

  tag {
    key                 = "name"
    value               = "main-autoscaled-ubuntu-instance"
    propagate_at_launch = true
  }
}

