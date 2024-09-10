locals {
  resource_id = "projects/my-project/zones/us-central1-c/instances/my-instance"

  project_name = split("/", local.resource_id)[1]

  location       = "  EUROPE - west1  \n"
  final_location = "europe-west1"

  trim_location    = trimspace(local.location)
  replace_location = replace(local.trim_location, " ", "")
  lower_location   = lower(local.replace_location)
}

output "location" {
  value = local.lower_location
}
