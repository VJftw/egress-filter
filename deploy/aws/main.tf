provider "aws" {
  region = "eu-west-1"
}

data "aws_region" "current" {}

terraform {

}

module "egress_proxy" {
  source = "//deploy/module/aws:aws"

  vpc_id = aws_vpc.main.id
  squid_subnet_ids = aws_subnet.public.*.id
  route_table_ids_to_transparently_proxy = [aws_route_table.private.id]
  
  domain_whitelist = [
    ".github.com",
  ]
}
