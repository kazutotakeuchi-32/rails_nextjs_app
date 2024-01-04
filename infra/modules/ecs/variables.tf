variable "aws_account_id" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "domain_name" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "db_name" {
  type = string

}
variable "db_subnet_group_name" {
  type = string

}

variable "db_instance" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "db_user_name" {
  type = string
}

variable "db_password" {
  type = string
}

variable "private_subet_ids" {
  type = list(string)
}

variable "public_subet_ids" {
  type = list(string)
}

variable "zone_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "lb_backend_target_type" {
  type = string
}

variable "lb_frontend_target_type" {
  type = string
}

variable "ecr_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "backend_service_name" {
  type = string
}

variable "frontend_service_name" {
  type = string
}

variable "frontend_desired_count" {
  type = number
}

variable "backend_desired_count" {
  type = number
}

variable "backend_task_definition" {
  type = string
}

variable "frontend_task_definition" {
  type = string
}