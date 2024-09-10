resource "google_storage_bucket" "bucket" {
  name     = "sto-student00-bucket"
  location = "europe-west1"

  labels = {
    created = formatdate("HH-mm-DD-MM-YYYY", timestamp())
  }
}