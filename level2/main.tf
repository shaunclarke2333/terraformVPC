# Terraform block with required provider and terraform version listed
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">=0.14.9"
}

# Provider block with region defined
provider "aws" {
  region = "us-east-1"
}

# Security group for the main-loab-balancer Allow port 80 TCP inbound to ELB
module "main-elb-tcp80" {
  source = "../mods/modules/security_group"
  sg_name = "main-load-balancer"
  sg_description = "Allow port 80 TCP inbound to ELB"
  vpc_id = data.terraform_remote_state.level1-main-vpc.outputs.main-vpc-id
  
  #ingress
  sg_ingress_description = "http to ELB"
  sg_ingress_from_port = 80
  sg_ingress_to_port = 80
  sg_ingress_protocol = "tcp"
  sg_ingress_cidr_blocks = ["0.0.0.0/0"]

  #egress
  sg_egress_from_port = 0
  sg_egress_to_port = 65535
  sg_egress_protocol = "tcp"
  sg_egress_cidr_blocks = ["0.0.0.0/0"]

  #tags
  sg_tag_name = "main-load-balancer"
}

#AWS ubuntu launch template
module "main-launch-template" {
  source = "../mods/modules/launch_template"
  launch_template_name = "main-launch-template"
  launch_template_id = data.aws_ami.ubuntu.id
  launch_template_instance_type = var.instance_type

  # Instance Profile
  iam_instance_profile_name = **instance-profile-here**
  vpc_security_group_ids = ["${module.main-elb-tcp80.main-security-group-output}"]
  
  # Tag specifications
  resource_type = "instance"

  #tags
  tag_name = "main-ubuntu"
}


#Application load balancer, target group and listener
module "main-elb" {
  source = "../mods/modules/load_balancer"
  load_balancer_name = "main-load-balancer"
  load_balancer_internal = false
  load_balancer_type = "application"
  security_groups = [module.main-elb-tcp80.main-security-group-output]
  subnets = [for subnet in data.terraform_remote_state.level1-main-vpc.outputs.main-public-subnet : subnet.id]
  name_tag = "main"

  # Target group for elb
  target_group_name = "main-target-group"
  target_group_port = 80
  target_group_protocol = "HTTP"
  vpc_id = data.terraform_remote_state.level1-main-vpc.outputs.main-vpc-id
  health_check_enabled = true
  health_check_path = "/"
  health_check_port = "traffic-port"
  health_check_healthy_threshold = 5
  health_check_unhealthy_threshold = 2
  health_check_timeout = 5
  health_check_interval = 30
  health_check_mathcer = 200

  # ELB listener to forward traffic from load balancer to target group
  listener_port = "80"
  listener_protocol = "HTTP"
  listener_defualt_action_type = "forward"
}

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
  launch_template_id = **launch template id here**
  launch_template_version = "$Latest"

  #tags
  tag_key = "name"
  tag_value = "main"
  propagate_at_launch = true
}

module "name" {
  source = ""
  
}

module "name" {
  source = ""
  
}

module "name" {
  source = ""
  
}

module "name" {
  source = ""
  
}

module "name" {
  source = ""
  
}

module "name" {
  source = ""
  
}


