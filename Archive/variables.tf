# Variables for test_module.tf

variable "create_resource_group" {
  type    = bool
  default = true
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "East US"
}

variable "enable_managed_identities" {
  type    = bool
  default = false
}

variable "enable_custom_roles" {
  type    = bool
  default = false
}

variable "enable_role_assignments" {
  type    = bool
  default = false
}

variable "managed_identities" {
  type    = map(any)
  default = {}
}

variable "custom_roles" {
  type    = map(any)
  default = {}
}

variable "role_assignments" {
  type    = map(any)
  default = {}
}

variable "tags" {
  type = map(string)
}
