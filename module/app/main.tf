resource "aws_instance" "instance" {
  ami ="ami-090252cbe067a9e58"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["allow-all"]
}