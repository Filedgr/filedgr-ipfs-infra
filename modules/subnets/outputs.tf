output "privateSubnetId" {
  value = aws_subnet.filegr-ipfs-subnet-priv.id
}

output "publicSubnetId" {
  value = aws_subnet.filegr-ipfs-subnet-pub.id
}