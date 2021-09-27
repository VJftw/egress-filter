resource "google_compute_subnetwork" "public" {
  project       = local.project
  name          = "public"
  ip_cidr_range = "10.0.1.0/24"
  region        = local.region
  network       = google_compute_network.main.id
}

resource "google_compute_subnetwork" "private" {
  project                  = local.project
  name                     = "private"
  ip_cidr_range            = "10.0.0.0/24"
  region                   = local.region
  network                  = google_compute_network.main.id
  purpose                  = "PRIVATE"
  private_ip_google_access = true
}
