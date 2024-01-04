module "network" {
  source = "./modules/network"
  vpc = {
    name = "${var.prefix}-${var.env}-vpc"
    cidr = "100.0.0.0/16"
  }
  igw_name = "${var.prefix}-${var.env}-igw"

  public_subnet_a = {
    name = "${var.prefix}-${var.env}-public-a"
    cidr = "100.0.1.0/24"
  }
  public_subnet_c = {
    name = "${var.prefix}-${var.env}-public-c"
    cidr = "100.0.2.0/24"
  }

  private_subnet_a = {
    name = "${var.prefix}-${var.env}-private-a"
    cidr = "100.0.100.0/24"
  }

  private_subnet_c = {
    name = "${var.prefix}-${var.env}-private-c"
    cidr = "100.0.101.0/24"
  }

  domain_name = "done-api.com"
}


module "ecs" {
  source = "./modules/ecs"

  # project_name
  project_name = "${var.prefix}-${var.env}"

  # network
  aws_account_id = data.aws_caller_identity.current.account_id
  domain_name    = "done-api.com"
  aws_profile    = var.aws_profile
  zone_id        = module.network.aws_route53_zone_id
  private_subet_ids = [
    module.network.private_subnet_a_id,
    module.network.private_subnet_c_id
  ]

  public_subet_ids = [
    module.network.public_subnet_a_id,
    module.network.public_subnet_c_id
  ]

  # RDS
  db_name              = var.prefix
  vpc_id               = module.network.vpc_id
  db_subnet_group_name = "${var.prefix}-${var.env}-db-subnet-group"
  db_instance          = "db.t2.micro"
  engine               = "mysql"
  engine_version       = "8.0.35"
  db_user_name         = "admin"
  db_password          = "password"

  #  ELB
  lb_frontend_target_type = "ip"
  lb_backend_target_type  = "ip"
  
  # ECR   
  ecr_name = "${var.prefix}-${var.env}-ecr"

  # ECS Cluster
  cluster_name = "${var.prefix}-${var.env}-cluster"

  # ECS Service
  service_name           = "${var.prefix}-${var.env}-service"
  frontend_service_name =  "${var.prefix}-${var.env}-frontend-service"
  backend_service_name  =  "${var.prefix}-${var.env}-backend-service"
  frontend_desired_count = 1
  backend_desired_count  = 1
   
  # ECS Task Definition
  backend_task_definition = "${var.prefix}-${var.env}-backend-task"
  frontend_task_definition = "${var.prefix}-${var.env}-frontend-task"

}
