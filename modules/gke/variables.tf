variable "gke_cluster_name" {
  description = "Nome do cluster GKE"
  type        = string
}

variable "node_pool_name" {
  description = "Nome do Node Pool"
  type        = string
}

variable "machine_type" {
  description = "Tipo de máquina para os nós do GKE"
  type        = string
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

variable "vpc_name" {
  description = "Nome da VPC vinda do módulo VPC"
  type        = string
}

variable "subnet_name" {
  description = "Nome da Subnet vinda do módulo VPC"
  type        = string
}

variable "region" {
  description = "Região onde a VPC será criada"
  type        = string
}
