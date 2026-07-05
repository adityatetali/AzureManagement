# Test configuration - uses variables from .tfvars files
# Usage: terraform plan -var-file=examples/scenario3-managed-identities-only.tfvars

module "iam" {
  source                = "app.terraform.io/adityatetaliorg/iam/azure"
  version               = "0.1.10"


  create_resource_group = var.create_resource_group
  resource_group_name   = var.resource_group_name
  location              = var.location

  enable_managed_identities = var.enable_managed_identities
  enable_custom_roles       = var.enable_custom_roles
  enable_role_assignments   = var.enable_role_assignments

  managed_identities = var.managed_identities
  custom_roles       = var.custom_roles
  role_assignments   = var.role_assignments

  tags = var.tags
}
