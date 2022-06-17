#Application load balancer
resource "aws_lb" "main-elb" {
  name               = "load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main-elb-tcp80.id]
  subnets            = [for subnet in data.terraform_remote_state.level1-main-vpc.outputs.main-public-subnet : subnet.id]

  tags = {
    Name = "main-elb"
  }
}

# Target group for main-elb
resource "aws_lb_target_group" "main-target-group" {
  name     = "main-instance-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.level1-main-vpc.outputs.main-vpc-id
  health_check {
    enabled             = true
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200

  }
}

# Resource to add ec2 instance to target group
resource "aws_lb_target_group_attachment" "main-attach-target-group" {
  target_group_arn = aws_lb_target_group.main-target-group.arn
  target_id        = aws_instance.main-ec2.id
  port             = 80
}

# ELB listener to forward traffic from load balancer to target group
resource "aws_lb_listener" "main-lb-listener" {
  load_balancer_arn = aws_lb.main-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main-target-group.arn
  }
}
