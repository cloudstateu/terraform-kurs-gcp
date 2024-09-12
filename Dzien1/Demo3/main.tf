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

  connection {
    type        = "ssh"
    user        = "myuser"
    private_key = file(local.private_key_path)
    host        = self.network_interface.0.access_config.0.nat_ip
  }

  provisioner "file" {
    source      = "./message.md"
    destination = "message.md"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install nginx -y",
      "sudo service nginx start"
    ]
  }

  provisioner "local-exec" {
    command = "echo ${self.network_interface.0.access_config.0.nat_ip} >> public_ips.txt"
  }
}