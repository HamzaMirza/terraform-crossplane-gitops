resource "kind_cluster" "this" {
  name           = var.cluster_name
  node_image     = var.node_image
  wait_for_ready = var.wait_for_ready

  # Terraform doesn't expand "~/" automatically, so we do it here.
  kubeconfig_path = var.kubeconfig_path == null ? null : pathexpand(var.kubeconfig_path)

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    dynamic "node" {
      for_each = var.nodes
      content {
        role                   = node.value.role
        kubeadm_config_patches = try(node.value.kubeadm_config_patches, [])

        dynamic "extra_port_mappings" {
          for_each = try(node.value.extra_port_mappings, [])
          content {
            container_port = extra_port_mappings.value.container_port
            host_port      = extra_port_mappings.value.host_port
            protocol       = try(extra_port_mappings.value.protocol, "TCP")
          }
        }
      }
    }
  }
}

