resource "google_compute_instance" "squid" {
  project = var.project

  name         = "squid"
  machine_type = "e2-medium"
  zone = "europe-west1-b"
  can_ip_forward = true

  tags = ["squid"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.coreos.id
    }
  }

  network_interface {
    network = var.network_id
    subnetwork = var.public_subnetwork_id
    # network    = google_compute_network.main.id
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    user-data = data.ignition_config.squid.rendered
  }
}
