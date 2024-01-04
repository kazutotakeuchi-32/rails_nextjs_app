/* 
  バックエンド用のターゲットグループを作成する
 */

resource "aws_lb_target_group" "backend" {
  name     = "${var.project_name}-backend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = var.lb_backend_target_type
  
}

/* 
  フロントエンド用のターゲットグループを作成する
*/
resource "aws_lb_target_group" "frontend" {
  name     = "${var.project_name}-frontend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = var.lb_frontend_target_type
}
