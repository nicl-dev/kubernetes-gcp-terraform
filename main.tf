terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
