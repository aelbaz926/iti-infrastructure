# VPC Module — Public + Private Subnets, IGW, and NAT

This Terraform module creates a simple AWS VPC setup with both **public** and **private** subnets, an **Internet Gateway (IGW)** for inbound/outbound internet access, and **NAT Gateway(s)** for private subnet egress.

It’s designed to be **easy to use and cost-efficient**, following the same layout as the *Lab5: VPC with Public + Private Subnets, IGW, and NAT* exercise.

---

## 🌐 What This Module Creates

| Resource | Description |
|-----------|-------------|
| **VPC** | Creates a VPC with DNS support and hostnames enabled |
| **Internet Gateway (IGW)** | Enables public internet access for public subnets |
| **Public Subnets** | Two subnets (by default) for public-facing resources |
| **Private Subnets** | Two subnets (by default) for backend resources |
| **NAT Gateway(s)** | Allows private subnets to access the internet |
| **Route Tables** | Public route table (via IGW) + private route tables (via NAT) |

---

## 🧱 Default CIDR Plan

| Component | CIDR | AZ Example |
|------------|------|------------|
| VPC | `10.42.0.0/16` | — |
| Public Subnet A | `10.42.1.0/24` | `eu-west-1a` |
| Public Subnet B | `10.42.2.0/24` | `eu-west-1b` |
| Private Subnet A | `10.42.11.0/24` | `eu-west-1a` |
| Private Subnet B | `10.42.12.0/24` | `eu-west-1b` |

---

## ⚙️ Module Inputs

| Name | Description | Type | Default |
|------|--------------|------|----------|
| `name_prefix` | Prefix for naming resources | `string` | `"lab5"` |
| `vpc_cidr` | CIDR block for the VPC | `string` | `"10.42.0.0/16"` |
| `azs` | List of Availability Zones | `list(string)` | n/a |
| `public_subnet_cidrs` | List of public subnet CIDRs | `list(string)` | `["10.42.1.0/24", "10.42.2.0/24"]` |
| `private_subnet_cidrs` | List of private subnet CIDRs | `list(string)` | `["10.42.11.0/24", "10.42.12.0/24"]` |
| `create_nat_per_az` | Whether to create a NAT per AZ (for HA) | `bool` | `false` |
| `tags` | Common tags for all resources | `map(string)` | `{}` |

---

## 📤 Outputs

| Name | Description |
|------|--------------|
| `vpc_id` | The ID of the created VPC |
| `igw_id` | Internet Gateway ID |
| `public_subnet_ids` | List of public subnet IDs |
| `private_subnet_ids` | List of private subnet IDs |
| `public_route_table_id` | Route table ID for public subnets |
| `private_route_table_ids` | List of route table IDs for private subnets |
| `nat_gateway_ids` | List of NAT Gateway IDs |
| `eip_ids` | List of allocated Elastic IPs for NAT gateways |

---

## 🚀 Example Usage

### 1. Local Reference (Inside Same Repo)
```hcl
module "vpc" {
  source = "../../modules/vpc"

  name_prefix          = "demo"
  vpc_cidr             = "10.42.0.0/16"
  azs                  = ["eu-west-1a", "eu-west-1b"]
  public_subnet_cidrs  = ["10.42.1.0/24", "10.42.2.0/24"]
  private_subnet_cidrs = ["10.42.11.0/24", "10.42.12.0/24"]

  # By default uses a single NAT (cost-efficient)
  # Set create_nat_per_az = true for HA
  create_nat_per_az = false

  tags = {
    Project = "ITI-Lab5"
    Owner   = "Ahmed"
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
