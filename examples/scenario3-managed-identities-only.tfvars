# ============================================
# SCENARIO 3: Only Managed Identities
# Use this when you only need to create managed identities
# ============================================

resource_group_name   = "rg-managed-id-test"
location              = "East US"
create_resource_group = true

enable_managed_identities = true
enable_custom_roles       = false
enable_role_assignments   = false

managed_identities = {
  "web-app-identity" = {
    tags = {
      Component = "WebApp"
      Tier      = "Frontend"
    }
  }
  "api-app-identity" = {
    tags = {
      Component = "API"
      Tier      = "Backend"
    }
  }
  "worker-identity" = {
    tags = {}
  }
}

custom_roles     = {}
role_assignments = {}

tags = {
  Application  = "ManagedIdentitiesOnly"
  Agency       = "TestAgency"
  Project_code = "MI001"
  Environment  = "Development"
  Owner        = "team@example.com"
}
