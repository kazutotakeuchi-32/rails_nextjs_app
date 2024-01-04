data "aws_caller_identity" "current" {}

# region
variable "aws_resion" {
  default = "ap-northeast-1"
}

# aws profile   
variable "aws_profile" {
  default = "zenn-test"
}

# prefix
variable "prefix" {
  default = "zenn"
}

variable "env" {
  default = "prod"
}

variable "domain_name" {
  default = "example.com"
}

variable "db_name" {
  default = "zenn"
}
variable "rds_name" {
    default = "zenn"
}

variable "db_user" {
    default = "zenn"
}

variable "db_password" {
    default = "password"
}

variable "db_instance" {
    default = "db.t2.micro"
}

variable "project_name" {
    default = ""
}


