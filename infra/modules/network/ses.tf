resource "aws_ses_domain_identity" "primary" {
  domain = var.domain_name
}

resource "aws_ses_domain_identity" "ses" {
  domain = var.domain_name
}
