resource "google_compute_instance" "controller" {
  count        = 3
  name         = "controller-${count.index}"
  machine_type = "e2-standard-2"

  can_ip_forward = true
  tags           = ["kubernetes-dev", "controller"]

  boot_disk {
    initialize_params {
      size  = 200
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network    = "kubernetes-dev"
    subnetwork = "kubernetes"
    network_ip = "10.240.0.1${count.index}"
    access_config {
      // Ephemeral public IP, if omitted instances can't be accessed via the Internet.
    }
  }

  service_account {
    scopes = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
  }
}

resource "google_compute_instance" "worker" {
  count        = 3
  name         = "worker-${count.index}"
  machine_type = "e2-standard-2"

  can_ip_forward = true
  tags           = ["kubernetes-dev", "worker"]

  metadata = {
    pod-cidr = "10.200.${count.index}.0/24"
  }

  boot_disk {
    initialize_params {
      size  = 200
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network    = "kubernetes-dev"
    subnetwork = "kubernetes"
    network_ip = "10.240.0.2${count.index}"
    access_config {
      // Ephemeral public IP, if omitted instances can't be accessed via the Internet.
    }
  }

  service_account {
    scopes = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
  }
}
