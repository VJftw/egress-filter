resource "google_compute_network" "main" {
    project = local.project
  name                    = "main"
  auto_create_subnetworks = false
}
