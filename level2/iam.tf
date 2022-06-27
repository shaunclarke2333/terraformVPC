#AWS policy for Amazon EC2 Role to enable AWS Systems Manager service core functionality
module "main-session-mamanger-policy" {
    source = "../mods/modules/iam_policy"
    policy_name = "main-session-mamanger-policy"
    policy_role = module.main-ssm-full-access.ssm-iam-role-output.id
    policy = data.aws_iam_policy.session-mamanger-policy.policy
}

#Sessions Manager role
module "main-ssm-full-access" {
    source = "../mods/modules/iam_role"
    role_name = "main-ssm-full-access"
    assume_role_policy_version = "2012-10-17"
    assume_role_policy_action = "sts:AssumeRole"
    assume_role_policy_effect = "Allow"
    assume_role_policy_principal_service = "ec2.amazonaws.com"
    assume_role_policy_tag_name = "main-ssm-full-access"
}

# Resource block for instance profile
module "main_iam_instance_profile" {
    source = "../mods/modules/iam_instance_profile"
    iam_instance_profile_name = "main-session-manager-profile"
    iam_instance_profile_role = module.main-ssm-full-access.ssm-iam-role-output.name
}
