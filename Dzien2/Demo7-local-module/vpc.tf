module "vpc_main" {
    source = "./modules/vpc"

    env = "test"
    project_name = "app"
    subnets = {
        subnet1 = {
            name = "subnet1"
            ip_cidr_range = "10.2.0.0/24"
            region = "europe-west1"
        }
        subnet2 = {
            name = "subnet2"
            ip_cidr_range = "10.2.1.0/24"
            region = "europe-west1"
        }
    }
}

module "vpc_secondary" {
    source = "./modules/vpc"

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

output "vpc_main" {
    value = module.vpc_main
}