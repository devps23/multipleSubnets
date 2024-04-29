resource "aws_vpc" "vpc" {
  cidr_block       = "10.10.0.0/24"
  tags = {
    Name = "vpc-aut-dev"
  }
}
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone     = "us-east-1"

  tags = {
    Name = "zone1"
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