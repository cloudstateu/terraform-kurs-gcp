variable "env_vars" {
  type        = map(string)
  default     = {
    ENV_VAR_1 = "Value1"
    ENV_VAR_2 = "Value2"
  }
}

resource "google_project_service" "run" {
    service = "run.googleapis.com"
}

resource "google_cloud_run_v2_service" "service" {
  name     = "cloudrun-demo"
  location = "europe-west1"
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"

  labels = {
    "cost-center" = "softwaremind"
    "owner" = "dawid"
  }

  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"

        env {
            name = "FOO1"
            value = "bar"
        }

        env {
            name = "FOO2"
            value = "bar"
        }

        dynamic "env" {
            for_each = var.env_vars

            content {
                name = env.key
                value = env.value
            }
        }
    }
  }

  depends_on = [
    google_project_service.run
  ]
}