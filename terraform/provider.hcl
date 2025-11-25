terraform {
  required_version = "~1.12.0"
}

generate kind {
  path      = "provider-kind.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOT
terraform {
    required_providers {
        kind = {
            source = "tehcyx/kind"
            version = "~> 0.10.0"
        }
    }
}
EOT
}

generate kubernetes {
  path      = "provider-kubernetes.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOT
terraform {
    required_providers {
        kubernetes = {
            source = "hashicorp/kubernetes"
            version = "~> 2.20.0"
        }
    }
}
EOT
}

generate helm {
  path      = "provider-helm.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOT
terraform {
    required_providers {
        helm = {
            source = "hashicorp/helm"
            version = "~> 2.10.0"
        }
    }
}
EOT
}