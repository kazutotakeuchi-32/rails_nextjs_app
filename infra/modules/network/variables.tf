# VPC
variable "vpc" {
  type = map(string)
  default = {
    "name" = "vpc"
    "cidr" = ""
  }
}

# パブリックサブネットA
variable "public_subnet_a" {
  type = map(string)
  default = {
    name = "public-a"
    cidr = "100.0.1.0/24"
  }
}

# パブリックサブネットC
variable "public_subnet_c" {
  type = map(string)
  default = {
    name = "public-c"
    cidr = "100.0.2.0/24"
  }
}

# プライベートサブネットA
variable "private_subnet_a" {
  type = map(string)
  default = {
    name = "private-a"
    cidr = "100.0.100.0/24"
  }
}

# プライベートサブネットC
variable "private_subnet_c" {
  type = map(string)
  default = {
    name = "private-c"
    cidr = "100.0.101.0/24"
  }
}

# DNSサポートの有効化
variable "enable_dns_support" {
  type    = bool
  default = true
}

# DNSホスト名の有効化
variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

# インターネットゲートウェイ
variable "igw_name" {
  type    = string
  default = "igw"
}

# ドメイン名
variable "domain_name" {
  type = string
}
