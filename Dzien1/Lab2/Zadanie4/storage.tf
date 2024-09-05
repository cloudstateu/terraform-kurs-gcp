resource "google_storage_bucket" "studentXX" {
  name          = "studentXX-bucket"
  location      = "europe-west1"
}

resource "google_project_service" "file" {
  service = "file.googleapis.com"
}

resource "google_filestore_instance" "student0" {
  name = "filest-${local.prefix}"
  tier = "BASIC_HDD"

  file_shares {
    capacity_gb = 1024
    name        = "share1"
  }

  networks {
    network = google_compute_network.shared.name
    modes   = ["MODE_IPV4"]
  }

  depends_on = [google_project_service.file]
}