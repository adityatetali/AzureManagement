# ============================================
# SCENARIO 2: Only Role Assignments (Built-in roles)
# Use this when you only need to assign existing/built-in roles
# ============================================
module "iam_role_assignments_only" {
  source                = "app.terraform.io/adityatetaliorg/iam/azure"
  version               = "0.1.10"
  resource_group_name   = "rg-existing"
  location              = "Central US"
  create_resource_group = true # Use existing RG

  enable_managed_identities = false
  enable_custom_roles       = false
  enable_role_assignments   = true

  managed_identities = {}
  custom_roles       = {}

  role_assignments = {
    "reader-assignment" = {
      scope              = "/subscriptions/38fe3474-4d82-4029-a49f-ba81a9ab017b/resourceGroups/rg-existing"
      custom_role        = false
      role_definition_id = "/subscriptions/38fe3474-4d82-4029-a49f-ba81a9ab017b/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7"
      principal_id       = "9e9ef130-b8b7-47ee-bfc5-9a6b19383a23"
      principal_type     = "ServicePrincipal"
    }
    "contributor-assignment" = {
      scope              = "/subscriptions/38fe3474-4d82-4029-a49f-ba81a9ab017b/resourceGroups/rg-existing"
      custom_role        = false
      role_definition_id = "/subscriptions/38fe3474-4d82-4029-a49f-ba81a9ab017b/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
      principal_id       = "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
      principal_type     = "Group"
    }
  }

  tags = {
    Application  = "RoleAssignmentsOnly"
    Agency       = "TestAgency"
    Project_code = "RA001"
    Environment  = "Production"
    Owner        = "team@example.com"
  }
}
