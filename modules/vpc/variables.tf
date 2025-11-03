variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "name_prefix" {
  description = "Name prefix for resources"
  type        = string
  default     = "iti"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.42.0.0/16"
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "public_subnets_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
  default     = ["10.42.1.0/24", "10.42.2.0/24"]
}

variable "private_subnets_cidrs" {
  description = "CIDRs for private subnets"
  type        = list(string)
  default     = ["10.42.11.0/24", "10.42.12.0/24"]
}

variable "create_nat_per_az" {
  description = "Create NAT per AZ (true) or a single NAT (flase)"
  type        = bool
  default     = false
}


variable "tags" {
  description = "Extra tags"
  type        = map(string)
  default     = {}
}
