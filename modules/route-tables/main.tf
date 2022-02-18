resource "aws_route_table" "filedgr-ipfs-public-rt" {
  vpc_id = var.vpcId
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.inetGwId
  }
}

resource "aws_route_table_association" "filedgr-public-rt-assoc" {
  route_table_id = aws_route_table.filedgr-ipfs-public-rt.id
  subnet_id = var.publicSubnet
}

resource "aws_route_table" "filedgr-ipfs-private-rt" {
  vpc_id = var.vpcId
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.natId
  }
}

resource "aws_route_table_association" "filedgr-private-rt-assoc" {
  route_table_id = aws_route_table.filedgr-ipfs-private-rt.id
  subnet_id = var.privateSubnet
}