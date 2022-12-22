data "azuread_client_config" "config" {}

resource "azuread_application" "myapp" {
  display_name = var.ad_service_principal_name
  owners       = [data.azuread_client_config.config.object_id]
  depends_on = [
    data.azuread_client_config.config,
  ]
}

resource "azuread_service_principal" "myspn" {
  application_id               = azuread_application.myapp.application_id
  owners                       = [data.azuread_client_config.config.object_id]
  app_role_assignment_required = true
  depends_on = [
    data.azuread_client_config.config,

  ]
}
resource "time_rotating" "time" {
  rotation_days = 7
}

resource "azuread_service_principal_password" "myspnkey" {
  service_principal_id = azuread_service_principal.myspn.object_id
  rotate_when_changed = {
    rotation = time_rotating.time.id
  }
}

data "azurerm_subscription" "mysubscrip" {}

resource "azurerm_role_assignment" "roleforspn" {
  scope                = data.azurerm_subscription.mysubscrip.id
  role_definition_name = var.service_principal_role_assignment
  principal_id         = azuread_service_principal.myspn.object_id
  depends_on = [
    data.azuread_client_config.config,

  ]

}
