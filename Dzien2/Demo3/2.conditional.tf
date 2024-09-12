variable "create_bucket" {
  type    = bool
  default = false
}

resource "google_storage_bucket" "bucket" {
  count = var.create_bucket == true ? 1 : 0

  name     = "bucket-storage00-student"
  location = "EU"
}

output "bucket_name" {
    value = var.create_bucket ? google_storage_bucket.bucket[0].name : null
}