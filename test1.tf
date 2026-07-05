# ============================================
# TFC-FRIENDLY CONFIGURATION FILE
# ============================================
# 
# This file is designed for use with Terraform Cloud.
# 
# INSTRUCTIONS:
# 1. Copy this file to terraform.tfvars for local testing
# 2. For TFC, upload variables via:
#    - TFC UI (app.terraform.io) → Workspace → Variables
#    - OR: Terraform CLI with -var flags
#    - OR: Use a separate file for sensitive values
#
# NOTE: Do NOT commit terraform.tfvars to git if it contains sensitive values!

# ============================================
# REQUIRED SETTINGS
# ============================================
module "iam" {
  source                = "app.terraform.io/adityatetaliorg/iam/azure"
  version               = "0.1.10"
  resource_group_name   = "rg-iam-tfc-test"
  location              = "Central US"
  create_resource_group = true

  # ============================================
  # FEATURE TOGGLES
  # ============================================

  enable_managed_identities = true
  enable_custom_roles       = true
  enable_role_assignments   = true

  # ============================================
  # MANAGED IDENTITIES
  # ============================================

  managed_identities = {
    "tfc-app-identity" = {
      tags = {
        ManagedBy = "TerraformCloud"
      }
    }
  }

  # ============================================
  # CUSTOM ROLES
  # ============================================

  custom_roles = {
    "storage-custom-reader" = {
      description = "Custom read-only role created via TFC"
      actions = [
        "Microsoft.Storage/storageAccounts/read"
      ]
      not_actions      = []
      data_actions     = []
      not_data_actions = []
    }
  }

  # ============================================
  # ROLE ASSIGNMENTS
  # ============================================
  # NOTE: Replace principal_id with your actual Azure AD object ID

  role_assignments = {
    "tfc-assignment" = {
      scope              = "/subscriptions/38fe3474-4d82-4029-a49f-ba81a9ab017b/resourceGroups/rg-iam-tfc-test"
      custom_role        = true
      role_name          = "storage-custom-reader"
      role_definition_id = ""
      principal_id       = "9e9ef130-b8b7-47ee-bfc5-9a6b19383a23"
      principal_type     = "User"
    }
  }

  # ============================================
  # TAGS
  # ============================================

  tags = {
    Application  = "TFC-Azure-IAM"
    Agency       = "DevOps"
    Project_code = "TFC001"
    Environment  = "Development"
    Owner        = "team@example.com"
    ManagedBy    = "TerraformCloud"
  }

  # ============================================
  # OPTIONAL
  # ============================================

  custom_roles_scope = "resource_group"
  # subscription_id = null  # Uncomment and set if needed
}
