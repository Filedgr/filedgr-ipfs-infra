resource "aws_vpc" "filedgr-ipfs-vpc" {
  cidr_block = "1.0.0.0/16"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  instance_tenancy = "default"

  tags = {
    Name = "filedgr-ipfs-vpc"
  }
}