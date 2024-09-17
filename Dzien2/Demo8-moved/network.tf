# resource "google_compute_network" "vpc" {
#   name                    = "vpc-app-prod"
#   auto_create_subnetworks = false
# }

# terraform state mv google_compute_network.vpc module.vpc_secondary.google_compute_network.vpc
# module "vpc_secondary" {
#     source = "../demo7-local-module/modules/vpc"

#     env = "prod"
#     project_name = "app"
#     subnets = {
#         subnet1 = {
#             name = "subnet3"
#             ip_cidr_range = "10.3.0.0/24"
#             region = "europe-west1"
#         }
#         subnet2 = {
#             name = "subnet4"
#             ip_cidr_range = "10.3.1.0/24"
#             region = "europe-west1"
#         }
#     }
# }

module "vpc_prod" {
    source = "../demo8-module/modules/vpc"

    env = "prod"
    project_name = "app"
    subnets = {
        subnet1 = {
            name = "subnet3"
            ip_cidr_range = "10.3.0.0/24"
            region = "europe-west1"
        }
        subnet2 = {
            name = "subnet4"
            ip_cidr_range = "10.3.1.0/24"
            region = "europe-west1"
        }
    }
}

# moved {
#     from = module.vpc_secondary
#     to = module.vpc_prod
# }