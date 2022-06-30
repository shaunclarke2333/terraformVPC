#Application load balancer, target group and listener
module "main-elb" {
  source = "../modules/load_balancers"

  # Security group for the main-loab-balancer Allow port 443 TCP inbound to ELB
  sg_name        = "main-elb-security-group"
  sg_description = "Allow port 443 TCP inbound"
  sg_vpc_id      = data.terraform_remote_state.level1-main-vpc.outputs.main-vpc-id

  #ingress
  sg_443_ingress_description = "https to ELB"
  sg_443_ingress_from_port   = 443
  sg_443_ingress_to_port     = 443
  sg_443_ingress_protocol    = "tcp"
  sg_443_ingress_cidr_blocks = ["0.0.0.0/0"]

  #egress
  sg_egress_from_port   = 0
  sg_egress_to_port     = 65535
  sg_egress_protocol    = "tcp"
  sg_egress_cidr_blocks = ["0.0.0.0/0"]

  #tags
  sg_tag_name = "main-elb"

  #Application load balancer
  load_balancer_name     = "main-load-balancer"
  load_balancer_internal = false
  load_balancer_type     = "application"
  subnets                = [for subnet in data.terraform_remote_state.level1-main-vpc.outputs.main-public-subnet : subnet.id]
  name_tag               = "main_elb"

  # Target group for elb
  target_group_name                = "main-target-group"
  target_group_port                = 80
  target_group_protocol            = "HTTP"
  vpc_id                           = data.terraform_remote_state.level1-main-vpc.outputs.main-vpc-id
  health_check_enabled             = true
  health_check_path                = "/"
  health_check_port                = "traffic-port"
  health_check_healthy_threshold   = 5
  health_check_unhealthy_threshold = 2
  health_check_timeout             = 5
  health_check_interval            = 30
  health_check_mathcer             = 200

  # ELB listener to forward traffic from load balancer to target group
  load_balancer_arn = module.main-elb.main-elb-output.arn
  listener_port     = "443"
  listener_protocol = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = module.elb_friendly_name.acm_certificate_output.certificate_arn

  #Default action type
  listener_defualt_action_type = "forward"
}
