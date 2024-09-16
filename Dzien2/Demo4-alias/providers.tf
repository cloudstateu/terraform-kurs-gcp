terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.2.0"
    }
  }
}

provider "google" {
  project = "prj-student00"
  region  = "europe-west1"
}

provider "google" {
  alias = "us"
  project = "prj-student00"
  region  = "us-central1"
}