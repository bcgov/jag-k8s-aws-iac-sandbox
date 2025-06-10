resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn  = "arn:aws:iam::899650033111:role/BCGOV_WORKLOAD_developer"
        username = "developer-user"
        groups   = ["system:masters"]
      }
    ])
  }
}
