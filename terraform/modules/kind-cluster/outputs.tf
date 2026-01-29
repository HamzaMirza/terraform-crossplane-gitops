output "kubeconfig" {
  description = "Kubeconfig content for the created kind cluster."
  value       = kind_cluster.this.kubeconfig
  sensitive   = true
}

output "endpoint" {
  description = "Kubernetes API server endpoint."
  value       = kind_cluster.this.endpoint
}

