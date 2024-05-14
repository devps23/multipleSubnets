module "vpc" {
  source = "./module/vpc"
  cidr_block = var.cidr_block
//  subnet_cidr_block = var.subnet_cidr_block
  vpc_name = var.vpc_name
  env = var.env
  available_zone= var.available_zone
  default_vpc_id = var.default_vpc_id
  default_route_table_id = var.default_route_table_id
  default_cidr_block = var.default_cidr_block
  frontend_subnet = var.frontend-subnet
//  backend_subnet = var.backend-subnet
//  mysql_subnet = var.mysql-subnet
  availability_zone = var.availability_zone
//  public_subnets = var.public_subnets
}