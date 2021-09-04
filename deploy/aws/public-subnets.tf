resource "aws_subnet" "public" {
  count = length(local.availability_zones)

  vpc_id = aws_vpc.main.id

  availability_zone = element(local.availability_zones, count.index)

  cidr_block = cidrsubnet(
    aws_vpc.main.cidr_block,
    ceil(log(length(local.availability_zones) * 2, 2)),
    count.index,
  )

  map_public_ip_on_launch = true

  tags = {
    "Name" = "public.${element(local.availability_zones, count.index)}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "public"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id

}

resource "aws_route_table_association" "public" {
  count = length(local.availability_zones)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
