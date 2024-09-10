resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_compute_network" "shared" {
  name                    = "${var.vpc_shared_name}-${local.prefix}"
  auto_create_subnetworks = false

  depends_on = [
    google_project_service.compute
  ]
}

resource "google_compute_subnetwork" "jumphost" {
  name          = "${var.sbn_jh_name}-${local.prefix}"
  network       = google_compute_network.shared.id
  ip_cidr_range = var.sbn_jh_range
}