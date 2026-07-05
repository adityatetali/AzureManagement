# ============================================
# SCENARIO 1: Only Resource Group (All features disabled)
# Use this when you just want to create/manage a resource group
# ============================================

resource_group_name   = "rg-only-test"
location              = "East US"
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
