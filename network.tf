
resource "google_compute_network" "vpc_network" {
  name                    = "kubernetes-dev"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "kubernetes"
  ip_cidr_range = "10.240.0.0/24"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "internal_firewall_rule" {
  name    = "kubernetes-dev-allow-internal"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.240.0.0/24", "10.200.0.0/16"]
}

resource "google_compute_firewall" "external_firewall_rule" {
  name    = "kubernetes-dev-allow-external"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_address" "public_ip" {
  name = "kubernetes-dev"
}
