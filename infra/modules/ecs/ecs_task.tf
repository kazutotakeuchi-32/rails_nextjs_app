# ECS 
/* 
  バックエンド用のタスク定義を作成する
  - nginxコンテナ 80:80
  - railsコンテナ 3000:3000
 */
resource "aws_ecs_task_definition" "backend" {
  family       = var.backend_task_definition
  cpu          = 256
  memory       = 512
  network_mode = "awsvpc"
  #FARGAATEを指定   
  requires_compatibilities = ["FARGATE"]
  # ECSタスク実行ロールを指定する  

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name  = "nginx"
      image = "${aws_ecr_repository.nginx.repository_url}:latest"
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]
      essential = true
      memory    = 128
      cpu       = 128
    },
    {
      name  = "rails"
      image = "${aws_ecr_repository.rails.repository_url}:latest"
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]
      environment = [
        {
            name = "RAILS_ENV"
            value = "production"
        },
        {
            name = "RAILS_MASTER_KEY"
            value = ""
        }
      ]
      essential = true
      memory    = 128
      cpu       = 128
    }
  ])
}

/* 
  フロントエンド用のタスク定義を作成する
  - nextコンテナ 80:80
 */

resource "aws_ecs_task_definition" "frontend" {
  family       = var.frontend_task_definition
  cpu          = 256
  memory       = 512
  network_mode = "awsvpc"
  #FARGAATEを指定   
  requires_compatibilities = ["FARGATE"]
  # ECSタスク実行ロールを指定する  

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "next"
      image = "${aws_ecr_repository.nextjs.repository_url}:latest"
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]
      essential = true
      memory    = 128
      cpu       = 128
    }
  ])

}
