terraform {
  required_version = ">= 0.13.0"

  required_providers {
    ignition = {
      source  = "community-terraform-providers/ignition"
      version = "2.1.2"
    }
  }
}
