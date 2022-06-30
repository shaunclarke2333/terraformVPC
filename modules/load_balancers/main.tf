# Security group for the main-loab-balancer Allow port 80 TCP inbound to ELB
resource "aws_security_group" "main-elb-tcp443" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.sg_vpc_id

  ingress {
    description = var.sg_443_ingress_description
    from_port   = var.sg_443_ingress_from_port
    to_port     = var.sg_443_ingress_to_port
    protocol    = var.sg_443_ingress_protocol
    cidr_blocks = var.sg_443_ingress_cidr_blocks
  }

  egress {
    from_port   = var.sg_egress_from_port
    to_port     = var.sg_egress_to_port
    protocol    = var.sg_egress_protocol
    cidr_blocks = var.sg_egress_cidr_blocks
  }

  tags = {
    Name = "${var.sg_tag_name}-sg"
  }
}

#Application load balancer.
resource "aws_lb" "main-elb" {
  name               = var.load_balancer_name
  internal           = var.load_balancer_internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.main-elb-tcp443.id]
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
