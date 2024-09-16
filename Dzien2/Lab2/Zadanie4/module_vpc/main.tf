data "google_compute_network" "shared" {
  name = "__NAZWA__SIECI__VPC__SHARED__"
}

resource "google_compute_network" "env" {
  name                    = "vpc-${var.env}"
  auto_create_subnetworks = "false"
}

resource "google_compute_network_peering" "env_to_shared" {
  name         = "peering-${var.env}-to-shared"
  network      = google_compute_network.env.self_link
  peer_network = data.google_compute_network.shared.self_link
}

resource "google_compute_network_peering" "shared_to_env" {
  name         = "peering-shared-to-${var.env}"
  network      = data.google_compute_network.shared.self_link
  peer_network = google_compute_network.env.self_link
}
