resource "aws_eip" "filedgr-ipfs-eip" {
  vpc = "true"
}

resource "aws_internet_gateway" "filedgr-ipfs-inet-gw" {
  vpc_id = var.vpcId
  tags   = {
    Name = "filedgr-ipfs-inet-gw"
  }
}

resource "aws_nat_gateway" "filedgr-ipfs-nat" {
  subnet_id = var.publicSubnetId
  allocation_id = aws_eip.filedgr-ipfs-eip.id
  tags      = {
    Name = "filedgr-ipfs-nat"
  }
}