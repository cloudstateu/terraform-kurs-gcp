module "service_account" {
  source     = "terraform-google-modules/service-accounts/google"
  version    = "~> 4.2"
  project_id = var.project_id
  prefix     = "sa-cloud-run"
  names      = ["simple"]
}

resource "google_project_service" "run" {
    service = "run.googleapis.com"
}

module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "~> 0.12"

  service_name          = "ci-cloud-run"
  project_id            = var.project_id
  location              = "us-central1"
  image                 = "us-docker.pkg.dev/cloudrun/container/hello"
  service_account_email = module.service_account.email

  depends_on = [
    google_project_service.run
  ]
}

output "cloud_run" {
    value = module.cloud_run.service_url
}