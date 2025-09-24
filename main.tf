module "api_enablement" {
  source       = "./modules/api_enablement"
  gcp_project  = var.gcp_project
}

resource "time_sleep" "wait_for_api" {
  depends_on = [module.api_enablement]
  create_duration = "60s" # ajuste o tempo conforme necessário
}

module "vpc" {
  depends_on   = [time_sleep.wait_for_api]
  source       = "./modules/vpc"
  vpc_name     = var.vpc_name
  subnet_name  = var.subnet_name
  region       = var.region
  gcp_project  = var.gcp_project
}

module "gke" {
  depends_on = [ module.vpc ]
  source          = "./modules/gke"
  gke_cluster_name = var.gke_cluster_name
  node_pool_name  = var.node_pool_name
  machine_type    = var.machine_type
  disk_size       = var.disk_size
  node_count      = var.node_count
  vpc_name        = module.vpc.vpc_name
  subnet_name     = module.vpc.subnet_name
  region          = var.region
  gcp_project     = var.gcp_project
}


# 🔹 IP reservado para peering (necessário para AlloyDB Private Service Access)
resource "google_compute_global_address" "alloydb_private_ip" {
  project       = var.gcp_project
  name          = "alloydb-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = module.vpc.network_self_link
}

# 🔹 Conexão de VPC Peering com Service Networking
resource "google_service_networking_connection" "alloydb_peering" {
  network                 = module.vpc.network_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.alloydb_private_ip.name]
}

resource "google_alloydb_cluster" "alloydb_cluster" {
  cluster_id   = var.cluster_alloy_id
  project      = var.gcp_project
  location     = var.region
  display_name = var.cluster_alloy_id

  initial_user {
    user     = "root"
    password = "root"
  }

  automated_backup_policy {
    enabled = false
  }

  network_config {
    network = "projects/${var.gcp_project}/global/networks/${var.vpc_name}"
  }
}
# 🔹 Instância primária
resource "google_alloydb_instance" "primary" {
  depends_on     = [google_alloydb_cluster.alloydb_cluster, google_service_networking_connection.alloydb_peering]
  instance_id   = "primary-instance"
  cluster       = google_alloydb_cluster.alloydb_cluster.id
  instance_type = "PRIMARY"

  machine_config {
    cpu_count = var.cluster_alloy_cpu
  }

  display_name = "alloydb-primary-instance"
}

# 🔹 Instância Read Replica (Read Pool)
resource "google_alloydb_instance" "read_replica_1" {
  depends_on     = [google_alloydb_instance.primary]
  instance_id   = "cluster-1-rr-1"
  cluster       = google_alloydb_cluster.alloydb_cluster.id
  instance_type = "READ_POOL"

  machine_config {
    cpu_count = var.cluster_alloy_cpu
  }

  display_name = "cluster-1-rr-1"

  read_pool_config {
    node_count = 1
  }
}


