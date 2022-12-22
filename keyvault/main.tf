resource "azurerm_key_vault" "mykv" {
  name                       = var.keyvault_name
  location                   = var.rsg_location
  resource_group_name        = var.rsg_name
  soft_delete_retention_days = var.soft_delete_retention_days
  tenant_id                  = data.azuread_client_config.config.tenant_id
  sku_name                   = var.key_vault_sku_name

  access_policy {
    tenant_id = data.azuread_client_config.config.tenant_id
    object_id = data.azuread_client_config.config.object_id

    key_permissions = [
      "Get",
      "List",
      "Purge",
      "Delete"
    ]

    secret_permissions = [
      "Get",
      "Set",
      "List",
      "Purge",
      "Delete"
    ]

    storage_permissions = [
      "Get",
      "Purge"
    ]
    }
}