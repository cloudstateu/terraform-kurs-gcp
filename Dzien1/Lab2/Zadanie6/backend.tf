terraform {
  backend "gcs" {
    bucket  = "xxx"
    prefix  = "tfstate"
  }
}
