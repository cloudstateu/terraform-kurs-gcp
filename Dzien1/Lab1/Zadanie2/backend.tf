terraform {
  backend "gcs" {
    bucket  = "student0-tfstate"
    prefix  = "tfstate"
  }
}
