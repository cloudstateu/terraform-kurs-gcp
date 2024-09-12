locals {
  public_key_path  = "~/.ssh/id_ed25519.pub"
  private_key_path = "~/.ssh/id_ed25519"
}

resource "google_compute_firewall" "allow-http-ssh" {
  name    = "allow-http-ssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-http-ssh"]
}

resource "google_compute_address" "static" {
  name = "ipv4-addr"
}

data "google_compute_image" "debian_image" {
  family  = "debian-11"
  project = "debian-cloud"
}

resource "google_compute_instance" "default" {
  name         = "my-vm"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"
  tags         = google_compute_firewall.allow-http-ssh.target_tags

  metadata = {
    ssh-keys = "myuser:${file(local.public_key_path)}"
  }

  metadata_startup_script = <<EOT
sudo apt-get update
sudo apt-get install nginx -y
sudo service nginx start
EOT

  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian_image.self_link
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
}