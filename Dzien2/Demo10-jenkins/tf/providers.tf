terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.3"
    }
  }
}

provider "google" {
  project = "prj-student00"
  region  = "europe-west1"
}