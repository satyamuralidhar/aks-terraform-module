
variable "keyvault_name" {
    type = string
    description = "keyvault name"
    validation {
      condition = length(var.keyvault_name) <=23 
      error_message = "name must be in between 3 to 24 charecters"
    }
}

variable "rsg_name" {
  type = string
}

variable "rsg_location" {
  type = string
}
variable "key_vault_sku_name" {}

variable "keyvault_tenant_id" {
}
variable "keyvault_object_id" {
}
variable "soft_delete_retention_days" {}