include "provider" {
  path = "${get_terragrunt_dir()}/../../provider.hcl"
}
terraform {
  source = "${get_terragrunt_dir()}/../../modules/kind-cluster"
}
locals {
  kubectl_config_path    = "~/.kube/config"
  cluster_name           = "kind"
  environment            = "development"
  node_image             = "kindest/node:v1.28.0"
  wait_for_ready         = true
  wait_for_ready_timeout = "10m"
  node_port              = 3009
  workers_count          = 1
  control_plane = {
    role = "control-plane"
    extra_port_mappings = [
      {
        container_port = local.node_port
        host_port      = local.node_port
        protocol       = "TCP"
      }
    ]
  }

  workers = [
    for idx in range(local.workers_count) : {
      role = "worker"
      kubeadm_config_patches = [<<EOF
        kind: JoinConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "node-type=worker,node-index=${idx + 1},environment=${local.environment}"
EOF
      ]
    }
  ]

  # kind expects a list of node definitions (control-plane + workers)
  nodes = concat([local.control_plane], local.workers)
}
inputs = {
  cluster_name    = local.cluster_name
  node_image      = local.node_image
  wait_for_ready  = local.wait_for_ready
  kubeconfig_path = local.kubectl_config_path
  nodes           = local.nodes
}