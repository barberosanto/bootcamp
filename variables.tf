variable "gcp_project" {
  description = "ID do projeto no GCP"
  type        = string
  default     = "test-bootcamp-06-2025"
}

variable "region" {
  description = "Região do GCP"
  type        = string
  default     = "us-east1"
}

variable "vpc_name" {
  description = "Nome da VPC"
  type        = string
  default     = "demo-vpc"
}

variable "subnet_name" {
  description = "Nome da Subnet"
  type        = string
  default     = "demo-subnet"
}

variable "gke_cluster_name" {
  description = "Nome do cluster GKE"
  type        = string
  default     = "demo-gke-cluster"
}

variable "node_pool_name" {
  description = "Nome do Node Pool"
  type        = string
  default     = "demo-node-pool"
}

variable "machine_type" {
  description = "Tipo de máquina para os nós do GKE"
  type        = string
  default     = "n2-custom-18-18432"
}

variable "disk_size" {
  description = "Tamanho do disco em GB"
  type        = number
  default     = 1000
}

variable "node_count" {
  description = "Número de nós no pool"
  type        = number
  default     = 4
}

variable "cluster_alloy_id" {
  description = "id do cluster alloydb"
  type        = string
  default     = "demo-cluster-alloy"
}

variable "cluster_alloy_cpu" {
  description = "CPU do cluster alloydb"
  type        = number
  default     = 2
  
}


