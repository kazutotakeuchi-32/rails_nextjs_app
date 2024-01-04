# RDSのセキュリティグループを作成する
resource "aws_security_group" "rds" {
  name        = "${var.db_name}-sg"
  description = "security group for ${var.db_name}"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.db_name}-sg"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDSのセキュリティグループにインバウンドルールを追加する（MySQLのポートを開ける）
resource "aws_security_group_rule" "mysql-rule" {
  depends_on = [ aws_security_group.rds, aws_security_group.ecs_backend ]
  security_group_id = aws_security_group.rds.id
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = aws_security_group.ecs_backend.id
}

