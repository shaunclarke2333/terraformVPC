#Application load balancer, target group and listener
module "main-elb" {
  source = "../mods/modules/load_balancers"
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
