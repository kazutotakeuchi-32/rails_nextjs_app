# VPC作成: 100.0.0.0/16
resource "aws_vpc" "this" {
  cidr_block = var.vpc["cidr"]
  
  tags = {
    Name = var.vpc["name"]
  }
}
