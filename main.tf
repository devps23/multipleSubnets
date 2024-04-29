module "vpc" {
  source = "./module/app"
  cidr_block = var.cidr_block
  vpc_name = var.vpc_name
  env = var.env
  available_zone= var.available_zone
  default_vpc_id = var.default_vpc_id
  default_route_table_id = var.default_route_table_id
}