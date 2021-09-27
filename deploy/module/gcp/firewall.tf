resource "google_compute_firewall" "allow_ingress_to_squid" {
    project = var.project
  name    = "squid-ingress"
  network = var.network_id

  allow {
    protocol = "tcp"
  }

  source_ranges = [
   "10.0.0.0/8", # TODO: use RFC ranges and set as variable   
  ]
}
