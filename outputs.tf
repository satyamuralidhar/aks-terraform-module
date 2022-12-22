output "keyvault_object_id" {
  value = module.keyvault.keyvault_object_id
}
output "keyvault_tenant_id" {
  value = module.keyvault.keyvault_tenant_id
}

output "key_vault_id" {
  value = module.keyvault.keyvault_id
}

//service principal outputs

output "service_principle_application_id" {
  value = module.serviceprincipal.service_principle_application_id
}
output "service_principle_object_id" {
  value = module.serviceprincipal.service_principle_object_id
}
output "service_principle_subscription_id" {
  value = module.serviceprincipal.service_principle_object_id
}
output "first_subnet_id" {
  value = module.vnet.first_subnet_id
}
# output "subnet_id" {
#   value = {
#     for id in var.subnet_cidr[0] : id => azurerm_subnet.subnet[id].id
#   }
# }