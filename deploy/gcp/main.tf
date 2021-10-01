provider "google" {

}

locals {
  region  = "europe-west1"
  project = "vjftw-main"
}

module "egress_proxy" {
  source = "//deploy/module/gcp:gcp"

  project = local.project

  network_id = google_compute_network.main.id
  public_subnetwork_id = google_compute_subnetwork.public.id

  core_authorized_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBh2SU+MzzzpTQ3BufCFgg18axoN5deZrpFWx/QYg3wp vj@vjpatel.me",
  ]
  
  domain_whitelist = [
    ".github.com",
  ]
}

resource "google_compute_instance" "test" {
  project = local.project
  name         = "test"
  machine_type = "g1-small"
  zone         = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.main.id
    subnetwork = google_compute_subnetwork.private.id
  }

}
