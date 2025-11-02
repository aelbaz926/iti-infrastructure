terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.19.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
}



resource "aws_instance" "web" {
  ami           = "ami-0ecb62995f68bb549"
  instance_type = "t3.micro"

  tags = {
    Name = "webserver-iti"
  }
}


output "public_ip" {
  description = "Public Ip address"
  value = aws_instance.web.public_ip
}
