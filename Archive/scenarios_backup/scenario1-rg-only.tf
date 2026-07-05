# ============================================
# SCENARIO 1: Only Resource Group (All features disabled)
# Use this when you just want to create/manage a resource group
# ============================================

module "iam" {
  source                = "app.terraform.io/adityatetaliorg/iam/azure"
  version               = "0.1.10"
  resource_group_name   = "rg-only-test1-aditya"
  location              = "Central US"
  create_resource_group = true

  enable_managed_identities = false
  enable_custom_roles       = false
  enable_role_assignments   = false

  managed_identities = {}
  custom_roles       = {}
  role_assignments   = {}

  tags = {
    Application  = "ResourceGroupOnly"
    Agency       = "TestAgency"
    Project_code = "RG001"
    Environment  = "Development"
    Owner        = "team@example.com"
  }
}
