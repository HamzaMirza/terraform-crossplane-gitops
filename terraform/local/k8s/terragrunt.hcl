include {
  path = find_in_parent_folders()
}
include "provider" {
  path = "${get_terragrunt_dir()}/../provider.hcl"
}
terraform {
  source = "git@github.com:tehcyx/terraform-provider-kind.git?ref=v0.10.0"
}
locals {
  kubectl_config_path    = "~/.kube/config"
  cluster_name           = "kind"
  environment            = "development"
  node_image             = "kindest/node:v1.28.0"
  wait_for_ready         = true
  wait_for_ready_timeout = "10m"
  node_port              = 3009
  workers_count          = 2
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


  dynamic "workers" {
    // Removed redundant 'role = "worker"' here
    for_each = range(local.workers_count)
    content {
      role = "worker"
      kubeadm_config_patches = [<<EOF
            kind: JoinConfiguration
            nodeRegistration:
                kubeletExtraArgs:
                    // Switched 'worker.key+1' to 'workers.value+1'
                    node-labels: "node-type=worker,node-index=${workers.value + 1},environment=${local.environment}" 
EOF
      ]
    }
  }
  nodes = merge(local.control_plane, local.worker)
}
inputs = {
  cluster_name           = local.cluster_name
  node_image             = local.node_image
  wait_for_ready         = local.wait_for_ready
  wait_for_ready_timeout = local.wait_for_ready_timeout
  nodes_count            = length(local.nodes)
  nodes                  = local.nodes
  kubectl_config_path    = local.kubectl_config_path
}