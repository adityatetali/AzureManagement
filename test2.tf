# Sample terraform.tfvars file for testing Azure IAM module
# Copy this file and modify values for your environment

# ============================================
# REQUIRED SETTINGS
# ============================================

# Resource Group Configuration
module "iam2" {
  source                = "app.terraform.io/adityatetaliorg/iam/azure"
  version               = "0.1.10"
  resource_group_name   = "rg-iam-tfc-test2"
  location              = "Central US"
  create_resource_group = true

  # Required Tags (must include all 5 keys)
  tags = {
    Application  = "TestApp"
    Agency       = "TestAgency"
    Project_code = "TEST001"
    Environment  = "Development"
    Owner        = "team@example.com"
  }

  # ============================================
  # FEATURE TOGGLES (Enable/Disable Features)
  # ============================================

  # Set to true/false to enable or disable specific features
  enable_managed_identities = false
  enable_custom_roles       = true
  enable_role_assignments   = false

  # ============================================
  # MANAGED IDENTITIES CONFIGURATION
  # ============================================
  # Only processed when enable_managed_identities = true

  managed_identities = {
    "app-identity-1" = {
      tags = {
        Environment = "Production"
        Application = "WebApp"
      }
    }
    "app-identity-2" = {
      tags = {
        Environment = "Staging"
        Application = "API"
      }
    }
  }

  # ============================================
  # CUSTOM ROLES CONFIGURATION
  # ============================================
  # Only processed when enable_custom_roles = true

  custom_roles = {
    "custom-storage-reader2" = {
      description = "Custom read-only role for storage accounts"
      actions = [
        "Microsoft.Storage/storageAccounts/blobServices/containers/read",
        "Microsoft.Storage/storageAccounts/blobServices/read",
        "Microsoft.Storage/storageAccounts/read"
      ]
      not_actions      = []
      data_actions     = []
      not_data_actions = []
    }
    "custom-vm-operator" = {
      description = "Custom role for VM operations"
      actions = [
        "Microsoft.Compute/virtualMachines/start/action",
        "Microsoft.Compute/virtualMachines/restart/action",
        "Microsoft.Compute/virtualMachines/deallocate/action",
        "Microsoft.Compute/virtualMachines/read"
      ]
      not_actions      = []
      data_actions     = []
      not_data_actions = []
    }
  }

  # ============================================
  # ROLE ASSIGNMENTS CONFIGURATION
  # ============================================
  # Only processed when enable_role_assignments = true

  role_assignments = {
    # Example 1: Assign a custom role (must match a key in custom_roles)
    "assign-storage-reader" = {
      scope              = "/subscriptions/38fe3474-4d82-4029-a49f-ba81a9ab017b/resourceGroups/rg-iam-test2"
      custom_role        = true
      role_name          = "custom-storage-reader"
      role_definition_id = "" # Not used when custom_role = true
      principal_id       = "9e9ef130-b8b7-47ee-bfc5-9a6b19383a23"
      principal_type     = "User"
    }

    # Example 2: Assign a built-in role by ID
    "assign-reader" = {
      scope              = "/subscriptions/38fe3474-4d82-4029-a49f-ba81a9ab017b/resourceGroups/rg-iam-test2"
      custom_role        = false
      role_name          = "" # Not used when custom_role = false
      role_definition_id = "/subscriptions/38fe3474-4d82-4029-a49f-ba81a9ab017b/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7"
      principal_id       = "9e9ef130-b8b7-47ee-bfc5-9a6b19383a23"
      principal_type     = "User"
    }
  }

  # ============================================
  # OPTIONAL SETTINGS
  # ============================================

  # Custom roles scope ("resource_group" or "subscription")
  custom_roles_scope = "resource_group"

  # Optional subscription ID (uses current subscription if not specified)
  # subscription_id = "38fe3474-4d82-4029-a49f-ba81a9ab017b"
}
