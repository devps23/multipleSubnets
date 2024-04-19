//variable "ami" {}
//variable "instanceType" {}
//variable "name" {}

variable "tools" {
  default = {
    prometheus = {
      ami = "ami-090252cbe067a9e58"
      instance_type="t3.small"
    }
  }
}