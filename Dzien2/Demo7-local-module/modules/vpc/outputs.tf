output "network" {
    value = google_compute_network.vpc
}

output "subnets" {
    value = google_compute_subnetwork.subnets
}

output "network_name" {
    value = google_compute_network.vpc.name
}