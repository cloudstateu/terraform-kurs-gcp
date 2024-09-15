resource "google_artifact_registry_repository" "student0" {
  repository_id = "areg-${local.prefix}"
  format        = "DOCKER"

  cleanup_policies {
    id     = "delete-legacy"
    action = "DELETE"
    condition {
      tag_state    = "TAGGED"
      tag_prefixes = ["legacy"]
    }
  }
  cleanup_policies {
    id     = "delete-old"
    action = "DELETE"
    condition {
      tag_state  = "UNTAGGED"
      older_than = "${100*24*60*60}s"
    }
  }
}