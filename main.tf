resource "azurerm_resource_group" "myrsg" {
  name     = var.rsg_name
  location = var.rsg_location
}

module "vnet" {
  source       = ".//vnet"
  vnet_name    = format("%s-%s-%s", var.rsg_location, "vnet", terraform.workspace)
  rsg_location = azurerm_resource_group.myrsg.location
  rsg_name     = azurerm_resource_group.myrsg.name
  vnet_cidr    = var.vnet_cidr
  //count         = length(var.subnet_cidr)
  subnet_name      = format("%s-%s-%s", "subnet", var.rsg_location, terraform.workspace)
  address_prefixes = var.address_prefixes
}

module "serviceprincipal" {
  source                            = "./service_principal"
  ad_service_principal_name         = var.ad_service_principal_name
  service_principal_role_assignment = var.service_principal_role_assignment

}
/* spn secret keys creation */
resource "time_rotating" "time" {
  rotation_days = 7
}

resource "azuread_service_principal_password" "myspnkey" {
  service_principal_id = module.serviceprincipal.service_principle_object_id
  rotate_when_changed = {
    rotation = time_rotating.time.id
  }
}


module "keyvault" {
  source                     = "./keyvault"
  keyvault_name              = format("%s-%s", var.rsg_location, "mykeyvault")
  rsg_name                   = var.rsg_name
  rsg_location               = var.rsg_location
  keyvault_tenant_id         = module.keyvault.keyvault_tenant_id
  keyvault_object_id         = module.keyvault.keyvault_object_id
  soft_delete_retention_days = var.soft_delete_retention_days
  key_vault_sku_name         = var.key_vault_sku_name
  depends_on = [
    module.vnet
  ]
}


resource "azurerm_key_vault_secret" "spnsecret" {
  name         = module.serviceprincipal.service_principle_object_id
  value        = azuread_service_principal_password.myspnkey.value
  key_vault_id = module.keyvault.keyvault_id
  depends_on = [
    module.keyvault
  ]
}


//aks cluster

module "aks_cluster" {
  source                 = "./aks"
  cluster_name           = var.cluster_name
  rsg_location           = var.rsg_location
  rsg_name               = var.rsg_name
  kubernetes_version     = module.aks_cluster.kubernetes_version
  sku_tier               = "Free"
  dns_prefix             = var.dns_prefix
  default_node_pool_name = var.default_node_pool_name
  vm_size                = var.vm_size
  ssh_pubkey             = file("./k8s_pubkey.pem")
  vnet_subnet_id         = module.vnet.first_subnet_id
  client_id              = module.serviceprincipal.service_principle_application_id
  client_secret          = module.serviceprincipal.serviceprinciple_password_value
  depends_on = [
    module.vnet,
    module.serviceprincipal,
    module.keyvault
  ]
}
