#AWS ubuntu launch template 
resource "aws_launch_template" "main-launch-temp" {
  name_prefix   = "main-launch-temp"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  iam_instance_profile {
    name = "main-launch-temp-profile"
  }

  vpc_security_group_ids = [
    "${aws_security_group.main-elb-tcp80.id}",
    "${aws_security_group.allow_ssh.id}"
  ]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "main-ubuntu-lt"
    }
  }
}

