locals {
  protocols_and_ports = [
    {
      protocol = "tcp",
      ports    = ["22"]
    },
    {
      protocol = "udp",
      ports    = ["53"]
    }
  ]
}

resource "google_compute_firewall" "allow_custom_ports" {
  name               = "allow-custom-ports"
  network            = google_compute_network.shared.name
  direction          = "INGRESS"
  destination_ranges = [google_compute_subnetwork.jumphost.ip_cidr_range]

  dynamic "allow" {
    for_each = local.protocols_and_ports
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }
}