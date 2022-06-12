# # Target group for main-elb
# resource "aws_lb_target_group" "main-target-group" {
#   name     = "main-instance-target-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.main.id
# }

# #Application load balancer
# resource "aws_lb" "main-elb" {
#   name               = "load-balancer"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.main-elb-tcp80.id]
#   subnets            = [for subnet in data.terraform_remote_state.main-vpc.outputs.main-private-subnet : subnet.id]

#   tags = {
#     Name = "main-elb"
#   }
# }

