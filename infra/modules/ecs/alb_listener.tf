/* 
  バックエンド用のリスナーを作成する
*/

# httpリスナー
resource "aws_lb_listener" "backend_listener_http" {
  load_balancer_arn = aws_lb.backend.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.backend.arn
    type             = "forward"
  }

  lifecycle {
    ignore_changes = [default_action]
  }

}

# httpsリスナー
resource "aws_lb_listener" "backend_listener_https" {
  load_balancer_arn = aws_lb.backend.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.this.arn

  default_action {
    target_group_arn = aws_lb_target_group.backend.arn
    type             = "forward"
  }

  lifecycle {
    ignore_changes = [default_action]
  }


}


/* 
  フロントエンド用のリスナーを作成する
*/

# httpリスナー(リダイレクト)
resource "aws_lb_listener" "frontend_listener_http_to_https" {
  load_balancer_arn = aws_lb.frontend.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  lifecycle {
    ignore_changes = [default_action]
  }

}


# httpsリスナー
resource "aws_lb_listener" "frontend_listener_https" {
  load_balancer_arn = aws_lb.frontend.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.this.arn

  default_action {
    target_group_arn = aws_lb_target_group.frontend.arn
    type             = "forward"
  }

  lifecycle {
    ignore_changes = [default_action]
  }


}
