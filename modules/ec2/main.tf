# AWS policy for Amazon EC2 Role to enable AWS Systems Manager service core functionality
resource "aws_iam_role_policy" "iam_role_policy" {
  name   = var.policy_name
  role   = aws_iam_role.iam_role.id
  policy = var.policy
}

#Sessions Manager role
resource "aws_iam_role" "iam_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "${var.assume_role_policy_version}"
    Statement = [
      {
        Action = "${var.assume_role_policy_action}"
        Effect = "${var.assume_role_policy_effect}"
        Sid    = ""
        Principal = {
          Service = "${var.assume_role_policy_principal_service}"
        }
      },
    ]
  })

  tags = {
    Name = "${var.assume_role_policy_tag_name}"
  }
}

# Resource block for instance profile
resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.iam_role.name
}


#AWS ubuntu launch template
resource "aws_launch_template" "launch-template" {
  name_prefix   = var.launch_template_name
  image_id      = var.launch_template_image_id
  instance_type = var.launch_template_instance_type
  user_data     = var.user_data

  iam_instance_profile {
    name = aws_iam_instance_profile.iam_instance_profile.name
  }

  vpc_security_group_ids = var.vpc_security_group_ids

  tag_specifications {
    resource_type = var.resource_type

    tags = {
      Name = "${var.tag_name}-launch-template"
    }
  }
}

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
    id      = aws_launch_template.launch-template.id
    version = var.launch_template_version
  }

  tag {
    key                 = var.tag_key
    value               = "${var.tag_value}-autoscaling-group"
    propagate_at_launch = var.propagate_at_launch
  }
}
