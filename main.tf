module "vpc" {
  source = "../modules/vpc"

  name_prefix = "iti-zag"
  vpc_cidr    = "10.42.0.0/16"
  azs         = ["us-east-1a", "us-east-1b"]

  public_subnets_cidrs  = ["10.42.1.0/24", "10.42.2.0/24"]
  private_subnets_cidrs = ["10.42.11.0/24", "10.42.12.0/24"]

  create_nat_per_az = false

  tags = {
    Project = "lab"
  }

}

