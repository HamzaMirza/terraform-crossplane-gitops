variable "cluster_name" {
  type        = string
  description = "Kind cluster name."
}

variable "node_image" {
  type        = string
  description = "Kind node image (e.g. kindest/node:v1.28.0)."
  default     = null
}

variable "wait_for_ready" {
  type        = bool
  description = "Whether to wait for the cluster control-plane to be ready."
  default     = false
}

variable "kubeconfig_path" {
  type        = string
  description = "Path where the kubeconfig file will be written."
  default     = null
}

variable "nodes" {
  description = "Kind nodes configuration (control-plane + workers)."
  type = list(object({
    role                   = string
    kubeadm_config_patches = optional(list(string), [])
    extra_port_mappings = optional(list(object({
      container_port = number
      host_port      = number
      protocol       = optional(string, "TCP")
    })), [])
  }))
  default = []
}

