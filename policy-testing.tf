
  module "policy" {
  source  = "app.terraform.io/adityatetaliorg/policy/azure"
  version = "0.0.1"
  scope_id = "/subscriptions/941863f5-fa95-4a2e-b1bc-7b46fd5e0236"

  policy_definitions = {
    require-tag-env = {
      display_name = "Require environment tag"
      policy_rule = jsonencode({
        if = {
          field  = "tags['environment']"
          exists = "false"
        }
        then = {
          effect = "deny"
        }
      })
    }
  }

  policy_assignments = {
    require-tag-env-assignment = {
      policy_definition_id = module.policy.policy_definition_ids["require-tag-env"]
      display_name         = "Enforce environment tag"
    }
  }
}
