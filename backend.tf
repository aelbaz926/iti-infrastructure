terraform {
  backend "s3" {
    bucket       = "iti-zag-394711685791"
    key          = "iti/dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
