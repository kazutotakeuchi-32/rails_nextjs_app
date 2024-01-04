# Next.js create Container Registry 
resource "aws_ecr_repository" "nextjs" {
  name                 = "${var.ecr_name}-nextjs"
  image_tag_mutability = "MUTABLE"
}

# Nginx create Container Registry
resource "aws_ecr_repository" "nginx" {
  name                 = "${var.ecr_name}-nginx"
  image_tag_mutability = "MUTABLE"
}

# Rails create Container Registry
resource "aws_ecr_repository" "rails" {
  name                 = "${var.ecr_name}-rails"
  image_tag_mutability = "MUTABLE"
}

# # Next.js create Container Registry Policy
# resource "aws_ecr_repository_policy" "nextjs" {
#   policy = jsonencode(
#     {
#       rules = [
#         {
#           action = {
#             type = "expire"
#           }
#           description  = "description"
#           rulePriority = 1
#           selection = {
#             countNumber = 10
#             countType   = "imageCountMoreThan"
#             tagStatus   = "any"
#           }
#         },
#       ]
#     }
#   )
#   repository = aws_ecr_repository.nextjs.name
# }

# # Nginx create Container Registry Policy
# resource "aws_ecr_repository_policy" "nginx" {
#   policy = jsonencode(
#     {
#       rules = [
#         {
#           action = {
#             type = "expire"
#           }
#           description  = "des"
#           rulePriority = 1
#           selection = {
#             countNumber = 10
#             countType   = "imageCountMoreThan"
#             tagStatus   = "any"
#           }
#         },
#       ]
#     }
#   )
#   repository = aws_ecr_repository.nginx.name
# }

# # Rails create Container Registry Policy
# resource "aws_ecr_repository_policy" "rails" {

#   policy = jsonencode(
#     {
#       rules = [
#         {
#           action = {
#             type = "expire"
#           }
#           description  = "des"
#           rulePriority = 1
#           selection = {
#             countNumber = 10
#             countType   = "imageCountMoreThan"
#             tagStatus   = "any"
#           }
#         },
#       ]
#     }
#   )
#   repository = aws_ecr_repository.rails.name
# }




