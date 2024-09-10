locals {
  vnet_address = "10.0.0.0/21"
}

output "subnet_addresses" {
  value = {
    app_subnet   = cidrsubnet(local.vnet_address, 3, 0) // /24
    data_subnet  = cidrsubnet(local.vnet_address, 3, 1) // /24
    cache_subnet = cidrsubnet(local.vnet_address, 3, 2) // /24
  }
}