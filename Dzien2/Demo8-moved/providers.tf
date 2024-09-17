terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.44"
    }
  }
}

provider "google" {
  project = "prj-student00"
  region  = "europe-west1"
}