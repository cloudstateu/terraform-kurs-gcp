resource "google_storage_bucket" "bucket" {
  name     = "sto-${var.environment_name}-${var.project_name}"
  location = "europe-west3"

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

resource "google_storage_bucket_iam_member" "public" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_object" "object" {
  name   = "index.html"
  bucket = google_storage_bucket.bucket.name
  source = "${path.module}/index.html"

  depends_on = [
    google_storage_bucket_iam_member.public
  ]
}