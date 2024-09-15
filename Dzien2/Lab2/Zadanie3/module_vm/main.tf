resource "google_service_account" "vm" {
  account_id   = "sa-vm-jh-${var.identifier}"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "jump_host" {
  name         = "vm-jh-${var.identifier}"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = var.subnetwork_name

    access_config {
      nat_ip = var.ip
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.vm.email
    scopes = ["cloud-platform"]
  }
}