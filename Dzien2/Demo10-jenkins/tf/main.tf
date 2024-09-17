resource "google_storage_bucket" "bucket" {
  name     = "sto-${var.environment_name}"
  location = "europe-west3"

  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}