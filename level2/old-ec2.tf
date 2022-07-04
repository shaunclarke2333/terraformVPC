# #Module to deploy autoscaling group with launch template and IAM session manager policy
# module "main-autoscaling-group" {
#   source = "../modules/ec2"

#   #AWS policy for Amazon EC2 Role to enable AWS Systems Manager service core functionality
#   policy_name = "main-session-mamanger-policy"
#   policy      = data.aws_iam_policy.session-mamanger-policy.policy

#   #Sessions Manager role.
#   role_name                            = "main-ssm-full-access"
#   assume_role_policy_version           = "2012-10-17"
#   assume_role_policy_action            = "sts:AssumeRole"
#   assume_role_policy_effect            = "Allow"
#   assume_role_policy_principal_service = "ec2.amazonaws.com"
#   assume_role_policy_tag_name          = "main-ssm-full-access"

#   # Resource block for instance profile
#   iam_instance_profile_name = "main-session-manager-profile"

#   # Security group for the main-loab-balancer Allow port 80 TCP inbound to instances
#   sg_name        = "main-lt-security-group"
#   sg_description = "Allow port 80 TCP inbound"
#   sg_vpc_id      = data.terraform_remote_state.level1-main-vpc.outputs.main-vpc-id

#   #ingress
#   sg_ingress_description = "http to instances"
#   sg_ingress_from_port   = 80
#   sg_ingress_to_port     = 80
#   sg_ingress_protocol    = "tcp"
#   sg_ingress_cidr_blocks = ["0.0.0.0/0"]

#   #ingress
#   sg_3306_ingress_description = "3306 sql port inbound"
#   sg_3306_ingress_from_port   = 3306
#   sg_3306_ingress_to_port     = 3306
#   sg_3306_ingress_protocol    = "tcp"
#   sg_3306_ingress_cidr_blocks = ["0.0.0.0/0"]


#   #egress
#   sg_egress_from_port   = 0
#   sg_egress_to_port     = 65535
#   sg_egress_protocol    = "tcp"
#   sg_egress_cidr_blocks = ["0.0.0.0/0"]

#   #tags
#   sg_tag_name = "main_launch_template"

#   #AWS ubuntu launch template
#   launch_template_name          = "main-launch-template"
#   launch_template_image_id      = data.aws_ami.ubuntu.id
#   launch_template_instance_type = var.instance_type
#   user_data                     = filebase64("ubuntu_bootstrap_webserver.sh")

#   # Tag specifications
#   resource_type = "instance"


#   #tags 
#   tag_name = "main-ubuntu"

#   # Autoscaling group using the main-launch-temp template
#   asg_name                      = "main-autoscaling-group"
#   asg_max_size                  = 5
#   asg_min_size                  = 2
#   asg_health_check_grace_period = 400
#   asg_health_check_type         = "EC2"
#   asg_desired_capacity          = 4
#   asg_force_delete              = true
#   asg_vpc_zone_identifier       = [for subnet in data.terraform_remote_state.level1-main-vpc.outputs.main-private-subnet : subnet.id]
#   asg_target_group_arns         = [module.main-elb.main-target-group.arn]

#   #launch_template
#   launch_template_version = "$Latest"

#   #tags
#   tag_key             = "name"
#   tag_value           = "main"
#   propagate_at_launch = true
# }
