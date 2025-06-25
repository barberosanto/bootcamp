resource "google_container_cluster" "gke_cluster" {
  name     = var.gke_cluster_name
  location = var.region
  network    = var.vpc_name
  subnetwork = var.subnet_name
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection = false
  project = var.gcp_project
}

resource "google_container_node_pool" "node_pool" {
  name       = var.node_pool_name
  cluster    = google_container_cluster.gke_cluster.name
  location   = var.region
  node_count = var.node_count
  project    = var.gcp_project

  node_config {
    machine_type = var.machine_type
    disk_size_gb = var.disk_size
    image_type   = "COS_CONTAINERD"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
