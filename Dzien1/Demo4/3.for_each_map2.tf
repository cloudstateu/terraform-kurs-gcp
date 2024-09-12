locals {
  services = {
    run    = "run.googleapis.com"
    tasks  = "tasks.googleapis.com"
    pubsub = "pubsub.googleapis.com"
  }
}

resource "google_project_service" "services" {
  for_each = local.services

  service = each.value
}
