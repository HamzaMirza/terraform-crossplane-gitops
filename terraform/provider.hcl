generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOT
terraform {
    required_providers {
        kind = {
            source  = "tehcyx/kind"
            version = "~> 0.10.0"
        }
        helm = {
            source  = "hashicorp/helm"
            version = "~> 2.10.0"
        }
        kubernetes = {
            source  = "hashicorp/kubernetes"
            version = "~> 2.20.0"
        }
    }
}
EOT
}