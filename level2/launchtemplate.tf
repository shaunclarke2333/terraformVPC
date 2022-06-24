#AWS ubuntu launch template 
resource "aws_launch_template" "main-launch-temp" {
  name_prefix   = "main-launch-temp"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  iam_instance_profile {
    name = "main-session-manager-profile"
  }

  vpc_security_group_ids = [
    "${aws_security_group.main-elb-tcp80.id}"
  ]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "main-ubuntu-lt"
    }
  }
}

