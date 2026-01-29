# terraform-crossplane-gitops
🚀 Infrastructure as Code: Terraform + Crossplane + GitOps | Automated Kubernetes cluster provisioning with Kind, Crossplane, ArgoCD installation, and CI/CD pipeline using GitHub Actions


# Common commands
terragrunt hclfmt
terragrunt validate
terragrunt run-all init --terragrunt-non-interactive
terragrunt run-all plan --terragrunt-non-interactive --refresh=true --lock=false


How it works
Storage: When you run Terraform, it sends your state file to TFstate.dev, which stores it securely (encrypted) in a managed backend.

Security: Your GitHub Token acts as the unique key. Only someone with that token (or your GitHub Action) can read or write the state.

Locking: If two people (or two actions) run at once, the lock_address ensures they don't corrupt the file.

# Note
Since you are using kind locally, remember that your GitHub Action cannot see your local kind cluster because it's running on your laptop's private network.

If you want the GitHub Action to actually manage your kind cluster, you would usually need to:

Run the GitHub runner locally (Self-hosted runner).