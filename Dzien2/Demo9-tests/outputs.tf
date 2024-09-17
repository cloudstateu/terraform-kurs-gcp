output "bucket_name" {
  value = google_storage_bucket.bucket.name
}

output "index_url" {
  value = google_storage_bucket_object.object.self_link
}