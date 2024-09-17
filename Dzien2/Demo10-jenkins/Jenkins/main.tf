locals {
  public_key_path  = "~/.ssh/id_ed25519.pub"
  private_key_path = "~/.ssh/id_ed25519"
}

resource "google_compute_firewall" "allow-http-ssh" {
  name    = "allow-http-ssh"
  network = "default"
  allow {
    protocol = "tcp"
    ports = ["8080", "80", "22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["allow-http-ssh"]
}

resource "google_compute_address" "static" {
  name = "ipv4-addr"
}

data "google_compute_image" "debian_image" {
  family  = "debian-11"
  project = "debian-cloud"
}

resource "google_compute_instance" "jenkins" {
  name         = "jenkins"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"
  tags         = google_compute_firewall.allow-http-ssh.target_tags

  metadata_startup_script = <<CLOUDINIT
#!/bin/bash
sudo apt-get update -y
sudo apt-get install openjdk-11-jdk -y
wget -qO - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update && sudo apt-get install jenkins -y
sudo service jenkins restart
CLOUDINIT

  metadata = {
    ssh-keys = "myuser:${file(local.public_key_path)}"
  }

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