resource google_compute_route route {
    project = var.project
  name = "nat-route"
  network = var.network_id
  dest_range = "0.0.0.0/0"
  tags = var.include_tags
  priority = 1000
  next_hop_instance = google_compute_instance.squid.self_link
#   next_hop_instance_zone = google_compute_instance.squid.zone
#   depends_on = [null_resource.delay_between_instance_and_route]
}
