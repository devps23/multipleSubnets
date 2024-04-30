resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_block
  tags = {
    Name = "${var.vpc_name} - ${var.env}"
  }
}
resource "aws_subnet" "public" {
  count                = length(var.public_subnets)
  vpc_id               = aws_vpc.vpc.id
  cidr_block           = var.public_subnets[count.index]
  availability_zone    = var.availability_zone[count.index]

  tags = {
    Name = "${var.env}-public-subnet-${count.index}"
  }
}
//resource "aws_subnet" "subnet" {
//  vpc_id     = aws_vpc.vpc.id
//  cidr_block       = var.subnet_cidr_block
//  availability_zone     = var.available_zone
//
//  tags = {
//    Name = "zone"
//  }
//}
resource "aws_subnet" "frontend" {
  count                = length(var.frontend_subnet)
  vpc_id               = aws_vpc.vpc.id
  cidr_block           = var.frontend_subnet[count.index]
  availability_zone    = var.availability_zone[count.index]

  tags = {
    Name = "${var.env}-frontend-subnet-${count.index}"
  }
}
resource "aws_subnet" "backend" {
  count                = length(var.backend_subnet)
  vpc_id               = aws_vpc.vpc.id
  cidr_block           = var.backend_subnet[count.index]
  availability_zone    = var.availability_zone[count.index]

  tags = {
    Name = "${var.env}-backend-subnet-${count.index}"
  }
}
resource "aws_subnet" "mysql" {
  count                = length(var.mysql_subnet)
  vpc_id               = aws_vpc.vpc.id
  cidr_block           = var.mysql_subnet[count.index]
  availability_zone    = var.availability_zone[count.index]

  tags = {
    Name = "${var.env}-mysql-subnet-${count.index}"
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
//create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw-${var.env}"
  }
}
//create route table(NAT Gateway)
resource "aws_route_table" "frontend" {
  count = length(var.frontend_subnet.index)
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.default_cidr_block[count.index]
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id[count.index]
  }
  tags = {
    Name = "route_table-${var.env}"
  }
}

//routing on both sides with customized peer connection
//resource "aws_route" "custom_vpc" {
//  route_table_id            =  var.default_route_table_id
//  destination_cidr_block    = var.cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
//}
//resource "aws_route" "default_vpc" {
//  route_table_id            =  aws_vpc.vpc.main_route_table_id
//  destination_cidr_block    = var.default_cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
//}

