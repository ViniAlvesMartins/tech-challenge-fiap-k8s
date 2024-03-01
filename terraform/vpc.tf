resource "aws_vpc" "network" {
  cidr_block = "192.168.0.0/20"

  tags = {
    resource = "network"
    terraform = "true"
  }
}

resource "aws_subnet" "eks-subnet" {
  vpc_id     = aws_vpc.network.id
  cidr_block = "192.168.0.0/22"

  tags = {
    resource = "network"
    terraform = "true"
  }
}