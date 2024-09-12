locals {
    buckets = [
        "storage-student00-a",
        # "storage-student00-b",
        "storage-student00-c",
        "storage-student00-d",
    ]
}

resource "google_storage_bucket" "buckets" {
    count = length(local.buckets)

  name          = local.buckets[count.index]
  location      = "EU"
}

output "bucket_name" {
    value = google_storage_bucket.buckets[2].name
}