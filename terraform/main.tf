provider "aws" {
  region = var.region
}

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}

module "security_groups" {
  source        = "./modules/security_groups"
  vpc_id        = module.vpc.vpc_id
  allowed_cidr  = var.allowed_cidr
  project_name  = var.project_name
}

module "ec2" {
  source            = "./modules/ec2"
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security_groups.ec2_sg_id
  instance_type     = var.instance_type
  public_key_path   = var.public_key_path
  project_name      = var.project_name
}