# ALBのセキュリティグループを作成

/* 
  バックエンド
  インバウンドルール
  ----------------------------
  80: HTTP ipV4 0.0.0.0/0
  80: HTTP ipV6 ::/0
  443: HTTPS ipV4 0.0.0.0/0
  443: HTTPS ipV6 ::/0
  ----------------------------
  アウトバウンドルール
  ----------------------------
  80: HTTP ipV4 ecs_backend_sg
  ----------------------------
 */

resource "aws_security_group" "elb_backend" {
  name   = "${var.project_name}-elb-backend-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.project_name}-elb-backend-sg"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_backend.id]
  }
}


/* 
  フロントエンド
  インバウンドルール
  ----------------------------
  80: HTTP ipV4 0.0.0.0/0
  80: HTTP ipV6 ::/0
  443: HTTPS ipV4 0.0.0.0/0
  443: HTTPS ipV6 ::/0
  ----------------------------
  アウトバウンドルール
  ----------------------------
  80: HTTP ipV4 ecs_frontend_sg
  ----------------------------
*/

resource "aws_security_group" "elb_frontend" {
  name   = "${var.project_name}-elb-frontend-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.project_name}-elb-frontend-sg"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_frontend.id]
  }


}

