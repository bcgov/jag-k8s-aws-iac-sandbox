data "kubernetes_config_map" "existing_aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
}

locals {
  existing_map_roles = try(yamldecode(data.kubernetes_config_map.existing_aws_auth.data["mapRoles"]), [])
  new_role = {
    rolearn  = "arn:aws:iam::899650033111:role/BCGOV_WORKLOAD_developer"
    username = "developer-user"
    groups   = ["system:masters"]
  }

  updated_map_roles = distinct(concat(local.existing_map_roles, [local.new_role]))
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode(local.updated_map_roles)
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels,
    ]
  }
}