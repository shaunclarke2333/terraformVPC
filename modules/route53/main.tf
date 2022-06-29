# DNS simple routing alias record
resource "aws_route53_record" "simple_alias_record" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = var.record_type

  alias {
    name                   = var.alias_name
    zone_id                = var.alias_zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}

# Creating aws ssl certificate
resource "aws_acm_certificate" "certificate" {
  domain_name       = var.domain_name
  validation_method = var.validation_method

  tags = {
    name = "${var.certificate_tag_name}-certificate"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Validating aws ssl certificate
resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [aws_route53_record.simple_alias_record.fqdn]
}