data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "jgersonorg1"

    workspaces = {
      name = "terraform-aws-compute-network"
    }
  }
}

module "security-group" {
  source  = "app.terraform.io/jgersonorg1/security-group/aws"
  version = "3.1.0"
  name    = "${var.prefix}-sg-demo-jgtest"
  vpc_id  = data.terraform_remote_state.vpc.outputs.vpc_id 
  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules           = ["https-443-tcp"]
}

module "ec2_instance" {
  source  = "app.terraform.io/jgersonorg1/ec2-instance/aws"
  version = "2.6.0"

  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name 
  name                   = "${var.prefix}-ec2-demo-jg" 
  vpc_security_group_ids = [ module.security-group.this_security_group_id ]
  subnet_id = data.terraform_remote_state.vpc.outputs.primary_subnet

  tags = {
    Terraform   = "true"
    Environment = var.env
    owner = var.owner
    ttl = var.ttl
  }
}
