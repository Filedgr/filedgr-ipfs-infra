output "private-subnet-id" {
  value = module.subnets.privateSubnetId
}

output "public-subnet-id" {
  value = module.subnets.publicSubnetId
}

output "vpcId" {
  value = module.vpc.vpcId
}

output "securityGroupId" {
  value = module.securityGroups.securityGroupId
}