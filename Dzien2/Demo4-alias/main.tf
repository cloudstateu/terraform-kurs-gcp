resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
}

resource "google_compute_subnetwork" "subnetwork_europe" {
  name          = "network-europe"
  ip_cidr_range = "10.2.0.0/16"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "subnetwork_us" {
  provider = google.us
  
  name          = "network-us"
  ip_cidr_range = "10.3.0.0/16"
  network       = google_compute_network.vpc_network.id
}