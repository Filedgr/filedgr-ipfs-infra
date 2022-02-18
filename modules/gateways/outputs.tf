output "natGatewayId" {
  value = aws_nat_gateway.filedgr-ipfs-nat.id
}

output "inetGatewayId" {
  value = aws_internet_gateway.filedgr-ipfs-inet-gw.id
}