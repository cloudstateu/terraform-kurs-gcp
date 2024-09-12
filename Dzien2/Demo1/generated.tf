# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "student0-bucket"
resource "google_storage_bucket" "bucket" {
  default_event_based_hold    = false
  enable_object_retention     = false
  force_destroy               = false
  labels                      = {}
  location                    = "EUROPE-WEST1"
  name                        = "student0-bucket"
  project                     = "prj-student00"
  public_access_prevention    = "enforced"
  requester_pays              = false
  rpo                         = null
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  soft_delete_policy {
    retention_duration_seconds = 604800
  }
}
