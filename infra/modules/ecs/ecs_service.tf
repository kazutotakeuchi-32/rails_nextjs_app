# ECSサービスの作成

# バックエンド用のECSサービスを作成する

resource "aws_ecs_service" "backend" {
  depends_on = [aws_lb.backend, aws_lb_target_group.backend, null_resource.docker_push]

  name    = var.backend_service_name
  cluster = aws_ecs_cluster.this.id

  task_definition = aws_ecs_task_definition.backend.family

  desired_count = var.backend_desired_count

  launch_type = "FARGATE"
  
  force_new_deployment = true

  network_configuration {
    subnets = var.public_subet_ids
    security_groups = [aws_security_group.ecs_backend.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.backend.arn
    container_name   = "nginx"
    container_port   = 80
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [ 
        load_balancer
     ]
  }


}

# フロントエンド用のECSサービスを作成する

resource "aws_ecs_service" "frontend" {
    depends_on = [aws_lb.frontend, aws_lb_target_group.frontend, null_resource.docker_push]
    
    name    = var.frontend_service_name
    cluster = aws_ecs_cluster.this.id
    
    task_definition = aws_ecs_task_definition.frontend.family
    
    desired_count = var.frontend_desired_count
    
    launch_type = "FARGATE"
    
    force_new_deployment = true
    
    network_configuration {
        subnets = var.public_subet_ids
        security_groups = [aws_security_group.ecs_frontend.id]
        assign_public_ip = true
    }
    
    load_balancer {
        target_group_arn = aws_lb_target_group.frontend.arn
        container_name   = "next"
        container_port   = 80
    }
    
    lifecycle {
        create_before_destroy = true
        ignore_changes = [ 
            load_balancer
         ]
    }
}