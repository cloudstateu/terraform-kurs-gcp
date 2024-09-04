terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.40.0"
    }
  }
}

provider "google" {
  project = "__ID__TWOJEGO__PROJEKTU__"
  region  = "europe-west1"
}
