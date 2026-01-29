locals {

}
generate "variables" {
  path      = "generated_variable.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  locals {
    default_tags = {
    ManagedBy = "Terraform"
    TerraformPath = "gcp/${path_relative_to_include()}"
    }
  }
  EOF
}

generate "backend" {
  path = "generated_backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
  terraform {
    backend "http" {
      address        = "https://api.tfstate.dev/github/v1"
      lock_address   = "https://api.tfstate.dev/github/v1/lock"
      unlock_address = "https://api.tfstate.dev/github/v1/lock"
      lock_method    = "PUT"
      unlock_method  = "DELETE"
      username       = "HamzaMirza/terraform-crossplane-gitops"
    }
  }
  EOF
}