# ELBの作成

/* 
 バックエンド用のELBを作成
 */
resource "aws_lb" "backend" {
  name               = "${var.project_name}-backend-elb"
  load_balancer_type = "application"
  internal           = false # 外部からのアクセスを許可する

  security_groups = [
    aws_security_group.elb_backend.id
  ]

  subnets = var.public_subet_ids

  tags = {
    Name = "${var.project_name}-backend-elb"
  }

}


/* 
 フロントエンド用のELBを作成
 */

resource "aws_lb" "frontend" {
  name               = "${var.project_name}-frontend-elb"
  load_balancer_type = "application"
  internal           = false # 外部からのアクセスを許可する

  security_groups = [
    aws_security_group.elb_frontend.id
  ]

  subnets = var.public_subet_ids

  tags = {
    Name = "${var.project_name}-frontend-elb"
  }
}

# Route53でAレコードにELBのDNS名を設定する

/* 
  バックエンド用のELBのDNS名をAレコードに設定する
 */
resource "aws_route53_record" "backend_lb" {
  zone_id = var.zone_id
  name    = "api"
  type    = "A"

  alias {
    name                   = aws_lb.backend.dns_name
    zone_id                = aws_lb.backend.zone_id
    evaluate_target_health = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

/* 
  フロントエンド用のELBのDNS名をAレコードに設定する
 */

resource "aws_route53_record" "frontend_lb" {
  zone_id = var.zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = aws_lb.frontend.dns_name
    zone_id                = aws_lb.frontend.zone_id
    evaluate_target_health = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
