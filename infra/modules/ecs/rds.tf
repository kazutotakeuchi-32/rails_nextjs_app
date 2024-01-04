resource "aws_db_instance" "rds" {
  # 割り当てるストレージのサイズ(GB)
  allocated_storage = 20
  # ストレージの種類
  storage_type = "gp2"
  # データベースの名前  
  engine         = var.engine
  engine_version = var.engine_version
  # インスタンスクラス
  instance_class = var.db_instance
  # データベースの識別子
  identifier = "${var.db_name}-rds"
  db_name        = var.db_name
  username       = var.db_user_name
  password       = var.db_password

  # インスタンス削除時にスナップショットの取得をスキップするかどうかの設定
  skip_final_snapshot = true

  # セキュリティグループの設定
  vpc_security_group_ids = [aws_security_group.rds.id]
  # サブネットグループの設定   
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  auto_minor_version_upgrade = true
  delete_automated_backups   = true
  multi_az                   = false
  publicly_accessible        = false

}

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = var.db_subnet_group_name
  description = "db subnet group for ${var.db_name}"
  subnet_ids  = var.private_subet_ids
}
