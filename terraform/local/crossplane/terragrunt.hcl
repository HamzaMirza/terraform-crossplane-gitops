include "provider" {
  path = "${get_terragrunt_dir()}/../../provider.hcl"
}
terraform {
  source = "${get_terragrunt_dir()}/../../modules/crossplane"
}
locals {
  kubectl_config_path = "~/.kube/config"
  cluster_name        = "kind"
  name                = "crossplane"
  repository          = "https://charts.crossplane.io/stable"
  chart               = "crossplane"
  version             = "1.14.0"
  set                 = []
}
inputs = {
  cluster_name           = local.cluster_name
  name                   = local.name
  repository             = local.repository
  kubernetes_config_path = local.kubectl_config_path
  chart                  = local.chart
  version                = local.version
  set                    = local.set
}