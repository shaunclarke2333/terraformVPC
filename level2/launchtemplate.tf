#AWS ubuntu launch template
module "main-launch-template" {
  source                        = "../mods/modules/launch_template"
  launch_template_name          = "main-launch-template"
  launch_template_image_id      = data.aws_ami.ubuntu.id
  launch_template_instance_type = var.instance_type

  # Instance Profile
  iam_instance_profile_name = module.main_iam_instance_profile.iam_instance_profile_output
  vpc_security_group_ids    = ["${module.main-elb-tcp80.main-security-group-output}"]

  # Tag specifications
  resource_type = "instance"

  #tags 
  tag_name = "main-ubuntu"
}
