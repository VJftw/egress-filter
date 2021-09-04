resource "aws_route" "transparent_proxy" {
  route_table_id              = var.route_table_ids_to_transparently_proxy[0]
  # destination_ipv6_cidr_block = "::/0"
  destination_cidr_block      = "0.0.0.0/0"
  network_interface_id        = aws_instance.squid.primary_network_interface_id
}
