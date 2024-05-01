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
//resource "aws_route" "r" {
//  route_table_id            = aws_route_table.testing.id
//  destination_cidr_block    = "10.0.1.0/22"
//  vpc_peering_connection_id = "pcx-45ff3dc1"
//}
