output "main-security-group-output" {
    description = "outputs the ID for main security group "
    value = aws_security_group.main-security-group.id
}
