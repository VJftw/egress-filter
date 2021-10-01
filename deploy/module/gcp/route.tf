resource google_compute_route route {
    project = var.project
  name = "default-egress-squid"
  network = var.network_id
  dest_range = "0.0.0.0/0"
  priority = 1000
  next_hop_instance = google_compute_instance.squid.self_link
}

resource google_compute_route squid {
    project = var.project
  name = "squid-egress"
  network = var.network_id
  dest_range = "0.0.0.0/0"
  tags = ["squid"]
  priority = 900
  next_hop_gateway = "default-internet-gateway"
}
