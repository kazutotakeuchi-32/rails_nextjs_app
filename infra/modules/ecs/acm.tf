# ワイルドカード証明証を作成
resource "aws_acm_certificate" "this" {
  domain_name = var.domain_name
  subject_alternative_names = [format("*.%s", var.domain_name)]

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = false
  }

  tags = {
    Name = "${var.domain_name}-wildcard"
  }
}

# ワイルドカード証明書の検証用のレコードを作成 
resource "aws_route53_record" "this" {
      for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
  allow_overwrite = true
}

# 証明書の検証
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]
}