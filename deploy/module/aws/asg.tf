resource "aws_instance" "squid" {
  ami           = data.aws_ami.coreos.id
  instance_type = var.instance_type

  user_data = data.ignition_config.squid.rendered

  tags = {
    Name = "Squid"
  }

  subnet_id = var.squid_subnet_ids[0]

  source_dest_check = false

  vpc_security_group_ids = [aws_security_group.squid.id]
}

resource "aws_security_group" "squid" {
  name        = "squid"
  description = "Squid Proxy"
  vpc_id      = var.vpc_id

  ingress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = var.squid_ingress_cidr_blocks
      description      = ""
      ipv6_cidr_blocks = var.squid_ingress_ipv6_cidr_blocks
      prefix_list_ids  = []
      security_groups  = var.squid_ingress_security_group_ids
      self             = false
    }
  ]

  egress = [
    {
      description      = ""
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Name = "squid"
  }
}
