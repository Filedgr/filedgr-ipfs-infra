data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "filegr-ipfs-subnet-priv" {
  vpc_id = var.vpcId
  cidr_block = "1.0.0.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
        Name = "filedgr-ipfs-subnet-priv"
    }
}

resource "aws_subnet" "filegr-ipfs-subnet-pub" {
  vpc_id = var.vpcId
  cidr_block = "1.0.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
        Name = "filedgr-ipfs-subnet-pub"
    }
}