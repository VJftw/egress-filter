resource "aws_subnet" "private" {
  count = length(local.availability_zones)

  vpc_id = aws_vpc.main.id

  availability_zone = element(local.availability_zones, count.index)

  cidr_block = cidrsubnet(
    aws_vpc.main.cidr_block,
    ceil(log(length(local.availability_zones) * 2, 2)),
    length(local.availability_zones) + count.index,
  )

  tags = {
    "Name" = "private.${element(local.availability_zones, count.index)}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "private"
  }
}

resource "aws_route_table_association" "private" {
  count = length(local.availability_zones)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}


resource "aws_security_group" "ssm" {
    name        = "ssm"
  description = "SSM"
  vpc_id      = aws_vpc.main.id

  ingress = [
    {
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
      description      = ""
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = []

  tags = {
    Name = "ssm"
  }
}

// SSM endpoints
resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ec2messages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ssm.id,
  ]

  subnet_ids = aws_subnet.private.*.id

  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssmmessages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ssm.id,
  ]

  subnet_ids = aws_subnet.private.*.id


  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ssm.id,
  ]

  subnet_ids = aws_subnet.private.*.id


  private_dns_enabled = true
}

// Launch an EC2 instance in a Private Subnet to test our Squid NAT instance
// You can connect to this via AWS SSM
data "aws_ami" "amazonlinux_2" {
 most_recent = true

  owners = ["amazon"]
 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}
resource "aws_instance" "test_instance" {
  ami           = data.aws_ami.amazonlinux_2.id
  instance_type = "t2.micro"

  tags = {
    Name = "Test Egress Filter"
  }

  subnet_id = aws_subnet.private[0].id

  vpc_security_group_ids = [aws_security_group.test_instance.id]
}

resource "aws_security_group" "test_instance" {
  name = "test-instance"
  description = "testing the egress-filter"

  vpc_id      = aws_vpc.main.id

  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Egress to everywhere (will only be the public subnet)"
    from_port = 0
    ipv6_cidr_blocks = [ ]
    prefix_list_ids = [ ]
    protocol = "-1"
    security_groups = [ ]
    self = false
    to_port = 0
  } ]
}
