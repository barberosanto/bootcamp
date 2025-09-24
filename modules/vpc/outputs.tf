output "vpc_name" {
  value = google_compute_network.vpc_network.name
}


output "network_self_link" {
  description = "The self-link of the VPC network"
  value       = google_compute_network.vpc_network.self_link
}

output "subnet_self_link" {
  description = "The self-link of the Subnet"
  value       = google_compute_subnetwork.subnet.self_link
}

output "subnet_name" {
  value = google_compute_subnetwork.subnet.name
}