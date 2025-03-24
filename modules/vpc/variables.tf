variable "vpc_name" {
  description = "Nome da VPC"
  type        = string
}

variable "subnet_name" {
  description = "Nome da Subnet"
  type        = string
}

variable "region" {
  description = "Região onde a VPC será criada"
  type        = string
}
