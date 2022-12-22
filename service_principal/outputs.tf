output "service_principle_application_id" {
 value = azuread_service_principal.myspn.application_id
}
output "service_principle_object_id" {
  value = azuread_service_principal.myspn.object_id
}
output "service_principle_subscription_id" {
  value = data.azurerm_subscription.mysubscrip.id
}

output "serviceprinciple_password_value" {
  value = azuread_service_principal_password.myspnkey.value
}

output "service_principle_tenant_id" {
  value = data.azurerm_subscription.mysubscrip.tenant_id
}