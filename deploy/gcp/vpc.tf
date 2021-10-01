resource "google_compute_network" "main" {
  project                 = local.project
  name                    = "main"
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "iap_ssh" {
  project = local.project

  name    = "main-iap-ssh"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
}

resource "google_compute_router" "router" {
  project       = local.project

  name    = "my-router"
  region  = google_compute_subnetwork.public.region
  network = google_compute_network.main.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  project       = local.project

  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.private.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
