resource "google_compute_instance" "squid" {
  project       = local.project

  name         = "Squid"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.coreos.id
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = google_compute_network.main.id
    subnetwork = google_compute_subnetwork.public.id

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    user-data = data.ignition_config.squid.rendered
  }
}
