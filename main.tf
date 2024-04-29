resource "aws_vpc" "vpc" {
  cidr_block       = "10.10.0.0/24"
  tags = {
    Name = "vpc-aut-dev"
  }
}
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block       = "10.10.0.0/24"
  availability_zone     = "us-east-1a"

  tags = {
    Name = "zone"
  }
}
resource "aws_vpc_peering_connection" "peer" {
  peer_vpc_id   = "vpc-02a94ee8944923438"
  vpc_id        = aws_vpc.vpc.id
  auto_accept   = true

  tags = {
    Name = "peer-dev"
  }
}
resource "aws_route" "r" {
  route_table_id            = "rtb-0a2e9ff93585c96fd"
  destination_cidr_block    = "10.10.0.0/24"
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}