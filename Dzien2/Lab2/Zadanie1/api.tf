locals {
  gcp_api = [
    "iam.googleapis.com",
    "sqladmin.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com"
  ]
}

resource "google_project_service" "prj_student00" {
  count   = length(local.gcp_api)
  service = local.gcp_api[count.index]
}