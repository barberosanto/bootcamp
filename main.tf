
module "api_enablement" {
  source      = "./modules/api_enablement"
  gcp_project = var.gcp_project
}

module "vpc" {
  depends_on = [ module.api_enablement ]
  source       = "./modules/vpc"
  vpc_name     = var.vpc_name
  subnet_name  = var.subnet_name
  region       = var.region
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
}


# resource "google_compute_global_address" "alloydb_private_ip" {
#   project       = var.gcp_project
#   name          = "alloydb-private-ip"
#   purpose       = "VPC_PEERING"
#   address_type  = "INTERNAL"
#   prefix_length = 16
#   network       = module.vpc.vpc_name  # Certifique-se que sua VPC está correta
# }

# resource "google_service_networking_connection" "alloydb_peering" {
#   network                 = module.vpc.vpc_name
#   service                 = "servicenetworking.googleapis.com"
#   reserved_peering_ranges = [google_compute_global_address.alloydb_private_ip.name]
# }

# module "alloy-db" {
#   source               = "GoogleCloudPlatform/alloy-db/google"
#   version              = "~> 3.0"
#   project_id           = var.gcp_project
#   cluster_id           = var.cluster_alloy_id
#   cluster_location     = var.region
#   cluster_display_name = var.cluster_alloy_id
#   cluster_initial_user = {
#     user     = "root",
#     password = "root"
#   }
#   network_self_link = module.vpc.vpc_name

#   automated_backup_policy = null

#   primary_instance = {
#     instance_id       = "primary-instance",
#     instance_type     = "PRIMARY",
#     machine_cpu_count = var.cluster_alloy_cpu,
#     database_flags    = {},
#     display_name      = "alloydb-primary-instance"
#   }

#   read_pool_instance = [
#     {
#       instance_id        = "cluster-1-rr-1"
#       display_name       = "cluster-1-rr-1"
#       require_connectors = false
#       machine_cpu_count  = var.cluster_alloy_cpu
#       ssl_mode           = "ALLOW_UNENCRYPTED_AND_ENCRYPTED"
#     }
#   ]

# }
