variable "node_group_name" {
  default = "dev-node-group"
}

variable "eks_node_role" {
  default = "airbyte-dev-node-role"
}

variable "eks_cluster_role" {
  default = "airbyte-dev-cluster-role"
}

variable "eks_cluster" {
  default = "jag-k8s-dev"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use"
  default     = "1.32"  
}

# variable "db_username" {
#   description = "The username for the database"
#   type        = string
# }

# variable "db_password" {
#   description = "The password for the database"
#   type        = string
#   sensitive   = true  
# }

variable "app_name" {
  description = "The name of the application"
  type        = string
  default     = "airbyte-webapp-svc"
}

variable "app_port" {
  description = "The port on which the application listens"
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "The path for the health check endpoint"
  type        = string
  default     = "/"
}

data "aws_availability_zones" "available" {}
