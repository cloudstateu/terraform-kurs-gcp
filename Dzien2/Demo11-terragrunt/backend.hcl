locals{
    bucket = "student0-tfstate"
}

generate "backend" {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"

    contents = <<EOF
terraform {
  backend "gcs" {
    bucket = "${local.bucket}"
    prefix = "tfstate/${path_relative_to_include()}"
  }
}
    EOF
}