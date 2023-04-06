terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = "niclas-test"
  region  = "europe-west3"
  zone    = "europe-west3-a"
}
