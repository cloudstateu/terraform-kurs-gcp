locals {
    buckets = [
        "storage-student00-a",
        # "storage-student00-b",
        "storage-student00-c",
        "storage-student00-d",
    ]

    buckets_set = toset(local.buckets)
}

resource "google_storage_bucket" "buckets" {
    for_each = local.buckets_set

  name          = each.key
  location      = "EU"
}

output "buckets" {
    value = keys(google_storage_bucket.buckets)
}