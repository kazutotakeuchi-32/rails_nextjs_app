resource "null_resource" "docker_push" {
  depends_on = [aws_ecr_repository.nextjs, aws_ecr_repository.nginx, aws_ecr_repository.rails]

  # ECRにログイン   
  provisioner "local-exec" {
    command = "$(aws ecr get-login-password --region ${var.aws_region} --profile ${var.aws_profile} | docker login --username AWS --password-stdin ${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com)"
  }

  # イメージをビルド
  provisioner "local-exec" {
    command = "docker build -t ${var.ecr_name}-nextjs -f ../next/Dockerfile.prod ../next "
  }

  provisioner "local-exec" {
    command = "docker build -t ${var.ecr_name}-nginx -f ../nginx/Dockerfile.prod ../nginx "
  }

  provisioner "local-exec" {
    command = "docker build -t ${var.ecr_name}-rails -f ../rails/Dockerfile.prod ../rails "
  }

  # タグ付け
  provisioner "local-exec" {
    command = "docker tag ${var.ecr_name}-nextjs:latest ${aws_ecr_repository.nextjs.repository_url}:latest"
  }

  provisioner "local-exec" {
    command = "docker tag ${var.ecr_name}-nginx:latest ${aws_ecr_repository.nginx.repository_url}:latest"
  }

  provisioner "local-exec" {
    command = "docker tag ${var.ecr_name}-rails:latest ${aws_ecr_repository.rails.repository_url}:latest"
  }


  # ECRにプッシュ
  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.nextjs.repository_url}:latest"
  }

  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.nginx.repository_url}:latest"
  }

  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.rails.repository_url}:latest"
  }


}
