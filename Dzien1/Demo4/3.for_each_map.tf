locals {
  services = {
      "run.googleapis.com"    = true
      "tasks.googleapis.com"  = false
      "pubsub.googleapis.com" = true
  }

  services_to_create = { for service, enabled in local.services : service => service if enabled == true }
}

resource "google_project_service" "project" {
  for_each = local.services_to_create

  service = each.value
}