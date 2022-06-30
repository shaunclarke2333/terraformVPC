#Application load balancer.
resource "aws_lb" "main-elb" {
  name               = var.load_balancer_name
  internal           = var.load_balancer_internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets

  tags = {
    Name = "${var.name_tag}-elb"
  }
}

# Target group for main-elb
resource "aws_lb_target_group" "main-target-group" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    enabled             = var.health_check_enabled
    path                = var.health_check_path
    port                = var.health_check_port
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
    matcher             = var.health_check_mathcer

  }
}

# # ELB listener to redirect traffic from port 80 listener to port 443 listener
# resource "aws_lb_listener" "main-lb-listener_port80" {
#   load_balancer_arn = aws_lb.main-elb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type = "redirect"

#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }

# ELB listener to forward traffic from load balancer to target group
resource "aws_lb_listener" "main-lb-listener_port443" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.listener_defualt_action_type
    target_group_arn = aws_lb_target_group.main-target-group.arn
  }
}
