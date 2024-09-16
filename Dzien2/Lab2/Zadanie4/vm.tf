module "address" {
  source  = "terraform-google-modules/address/google"
  version = "4.0.0"
  # insert the 2 required variables here
  project_id   = data.google_project.student00.project_id
  region       = "europe-west1"
  address_type = "EXTERNAL"

  names = [
    "public-ip-01",
    "public-ip-02"
  ]
}

output "vm_addresses" {
  value = module.address.addresses
}

module "vm_jh_1" {
  source          = "./module_vm"
  identifier      = "1"
  subnetwork_name = google_compute_subnetwork.jumphost.name
  ip              = module.address.addresses[0]
}
