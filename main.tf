terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
  
  backend "s3" {
    bucket = "terraform-20220210205113858700000002"
    key    = "16da99fe-aca0-4a54-8194-4057de64b8ff"
    region = "eu-central-1"
  }
}

provider "aws" {
  region  = "eu-central-1"
}

#Creating the VPC
module "vpc" {
  source = "./modules/vpc"
}

#Adding a single subnet to the VPC
module "subnets" {
  depends_on = [module.vpc]
  source = "./modules/subnets"

  #Vars
  vpcId  = module.vpc.vpcId
}

#Creating the gateways
module "gateways" {
  depends_on = [module.subnets, module.subnets]
  source = "./modules/gateways"

  #Vars
  publicSubnetId = module.subnets.publicSubnetId
  vpcId = module.vpc.vpcId

}

module "routingTables" {
  depends_on = [module.vpc, module.subnets, module.gateways]
  source = "./modules/route-tables"

  #Vars
  vpcId = module.vpc.vpcId
  inetGwId = module.gateways.inetGatewayId
  natId = module.gateways.natGatewayId
  publicSubnet = module.subnets.publicSubnetId
  privateSubnet = module.subnets.privateSubnetId

}

#Creating the security group for the IPFS ports
module "securityGroups" {
  depends_on = [module.subnets]

  #Vars
  vpcId = module.vpc.vpcId

  source = "./modules/security-groups"
}

module "kms" {
  source = "./modules/kms"
}

module "ecr" {
  depends_on = [module.kms]
  source = "./modules/ecr"
  ecr_kms_key = module.kms.kms_key_id
}
