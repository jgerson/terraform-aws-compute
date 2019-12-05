module "vpc" {
  source  = "app.terraform.io/TonyPulickal/vpc/aws"
  version = "2.9.0"

  name = "${var.prefix}-vpc-demo"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-1a", "us-west-1b", "us-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = var.env 
    owner = var.owner
  }
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "primary_subnet" {
  description = "primary private subnet"
  value       = module.vpc.private_subnets[0]
}
