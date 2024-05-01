//create a new vpc
resource "aws_vpc" "vpc" {
  cidr_block       = "10.10.128.0/17"
  tags = {
    Name = "vpc-dev"
  }
}
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.10.128.0/17"

  tags = {
    Name = "subnet-dev"
  }
}
resource "aws_vpc_peering_connection" "peer" {
  peer_vpc_id   = "vpc-02a94ee8944923438"
  vpc_id        = aws_vpc.vpc.id
}
resource "aws_route" "default_route" {
  route_table_id            = aws_vpc.vpc.main_route_table_id
  destination_cidr_block    = "172.31.0.0/16"
  vpc_peering_connection_id = "pcx-0d90eec12f8602793"
}

