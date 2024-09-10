# locals {
#     raw_json = file("${path.module}/3.json")
#     json = jsondecode(local.raw_json)
# }


# resource "google_storage_bucket" "bucket" {
#   name          = local.json.name
#   location      = local.json.location
# }