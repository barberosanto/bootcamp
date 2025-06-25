resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = var.gcp_project
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  network       = google_compute_network.vpc_network.self_link
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  project       = var.gcp_project
}
