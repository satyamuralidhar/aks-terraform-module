//rsg and vnet subnet details 
rsg_name         = "myrsg"
rsg_location     = "eastus"
vnet_cidr        = ["192.168.0.0/16"]
address_prefixes = ["192.168.1.0/24"]
//address_prefixes  = ["192.168.1.0/24", "192.168.2.0/24"]

//keyvault and servic principles details
key_vault_sku_name                = "standard"
env                               = "Development"
soft_delete_retention_days        = 7
ad_service_principal_name         = "myserviceprincipal"
key_vault_resource_group_name     = "myrsg-Development"
service_principal_role_assignment = "contributor"

//aks
cluster_name           = "myakscluster"
default_node_pool_name = "myaksdefpool"
dns_prefix             = "myaks"
vm_size                = "Standard_D2_v2"
