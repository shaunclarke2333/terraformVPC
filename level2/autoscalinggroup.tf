# Autoscaling group using the main-launch-temp template
module "main-autoscaling-group" {
  source = "../mods/modules/autoscaling_group"
  asg_name = "main-autoscaling-group"
  asg_max_size = 5
  asg_min_size = 2
  asg_health_check_grace_period = 200
  asg_health_check_type = "EC2"
  asg_desired_capacity = 4
  asg_force_delete = true
  asg_vpc_zone_identifier = [for subnet in data.terraform_remote_state.level1-main-vpc.outputs.main-private-subnet : subnet.id]
  asg_target_group_arns = [module.main-elb.main-target-group.arn]
  
  #launch_template
  launch_template_id = module.main-launch-template.main_launch_template.id
  launch_template_version = "$Latest"

  #tags
  tag_key = "name"
  tag_value = "main"
  propagate_at_launch = true
}