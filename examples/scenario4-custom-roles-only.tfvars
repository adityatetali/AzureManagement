# ============================================
# SCENARIO 4: Custom Roles Only (No assignments)
# Use this when you want to define custom roles for later use
# ============================================

resource_group_name   = "rg-custom-roles-test"
location              = "East US"
create_resource_group = true

enable_managed_identities = false
enable_custom_roles       = true
enable_role_assignments   = false

managed_identities = {}

# Define multiple custom roles
custom_roles = {
  "storage-data-operator" = {
    description = "Can read and write storage blob data"
    actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/read",
      "Microsoft.Storage/storageAccounts/blobServices/read"
    ]
    not_actions = []
    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write"
    ]
    not_data_actions = []
  }
  "vm-operator-limited" = {
    description = "Can start and stop VMs but not delete"
    actions = [
      "Microsoft.Compute/virtualMachines/start/action",
      "Microsoft.Compute/virtualMachines/deallocate/action",
      "Microsoft.Compute/virtualMachines/read",
      "Microsoft.Compute/virtualMachines/instanceView/read"
    ]
    not_actions = [
      "Microsoft.Compute/virtualMachines/delete",
      "Microsoft.Compute/virtualMachines/write"
    ]
    data_actions     = []
    not_data_actions = []
  }
}

role_assignments = {}

tags = {
  Application  = "CustomRolesOnly"
  Agency       = "TestAgency"
  Project_code = "CR001"
  Environment  = "Staging"
  Owner        = "team@example.com"
}

# Create at subscription scope so roles can be used across resource groups
custom_roles_scope = "subscription"
