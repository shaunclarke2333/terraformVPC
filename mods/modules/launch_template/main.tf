#AWS ubuntu launch template
resource "aws_launch_template" "launch-template" {
  name_prefix   = var.launch_template_name
  image_id      = var.launch_template_image_id
  instance_type = var.launch_template_instance_type

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  vpc_security_group_ids = var.vpc_security_group_ids

  tag_specifications {
    resource_type = var.resource_type

    tags = {
      Name = "${var.tag_name}-launch-template"
    }
  }
}
