resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_block
  tags = {
    Name = "${var.vpc_name} - ${var.env}"
  }
}
//resource "aws_subnet" "subnet" {
//  vpc_id     = aws_vpc.vpc.id
//  cidr_block       = var.cidr_block
//  availability_zone     = var.available_zone
//
//  tags = {
//    Name = "zone"
//  }
//}
resource "aws_subnet" "frontend" {
  count                = length(var.frontend_subnet)
  vpc_id               = aws_vpc.vpc.id
  cidr_block           = var.cidr_block[count.index+1]
  availability_zone    = var.availability_zone[count.index+1]

  tags = {
    Name = "${var.env}-frontend-subnet-${count.index+1}"
  }
}
//peer connection between two vpc's
resource "aws_vpc_peering_connection" "peer" {
  peer_vpc_id   = var.default_vpc_id
  vpc_id        = aws_vpc.vpc.id
  auto_accept   = true

  tags = {
    Name = "peer-dev"
  }
}
//routing on both sides with customized peer connection
resource "aws_route" "custom_vpc" {
  route_table_id            =  var.default_route_table_id
  destination_cidr_block    = var.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
resource "aws_route" "default_vpc" {
  route_table_id            =  aws_vpc.vpc.main_route_table_id
  destination_cidr_block    = var.default_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

