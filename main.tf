module "vpc" {
  source = "./module/app"
  cidr_block = var.vpc_cidr_block
  vpc_name  = var.vpc_name
  env = var.env
}