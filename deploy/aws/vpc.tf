data "aws_availability_zones" "available" {
}

locals {
  availability_zones = flatten(data.aws_availability_zones.available.*.names)
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  enable_dns_support = true // required to resolve dns requests

  enable_dns_hostnames = true // required for privatelink

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}
