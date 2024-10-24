variable "node_group_name" {
  default = "sandbox-node-group"
}

variable "eks_node_role" {
  default = "airbyte-sandbox-role"
}

variable "eks_cluster_role" {
  default = "airbyte-role"
}

variable "eks_cluster" {
  default = "k8s-airbyte-sandbox"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use"
  default     = "1.30"  
}


data "aws_availability_zones" "available" {}
