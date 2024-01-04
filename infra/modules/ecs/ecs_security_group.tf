# ECS用のセキュリティグループを作成する
/* 
  バックエンド
  インバウンドルール
  ----------------------------
  80: HTTP ipV4 0.0.0.0/0
  80: HTTP ipV6 ::/0
  ----------------------------
  アウトバウンドルール
  ----------------------------
  80: HTTP ipV4 0.0.0.0./0
  ----------------------------
*/
resource "aws_security_group" "ecs_backend" {
  name        = "${var.project_name}-ecs-backend-sg"
  description = "security group for ${var.project_name}-ecs-backend"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-ecs-backend-sg"
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

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


/* 
  フロントエンド
  インバウンドルール
  ----------------------------
  80: HTTP ipV4 0.0.0.0/0
  80: HTTP ipV6 ::/0
  ----------------------------
  アウトバウンドルール
  ----------------------------
  80: HTTP ipV4 0.0.0.0./0
  ----------------------------
 */
resource "aws_security_group" "ecs_frontend" {
  name        = "${var.project_name}-ecs-frontend-sg"
  description = "security group for ${var.project_name}-ecs-frontend"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-ecs-frontend-sg"
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

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
