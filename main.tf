//module "demo" {
//  source = "./modules/app"
//  ami = var.ami
//  instance_type = var.instanceType
//  tag_name = var.name
//}
module "demo" {
  for_each = var.tools
  source = "./modules/app"
  name = each.key
  ami = each.value["instance_type"]
  instance_type = each.value["instance_type"]

}