variable "rsg_name" {}
variable "rsg_location" {}
variable "vnet_cidr" {
  type = list(any)
}
//variable "subnet_cidr" {}

variable "ad_service_principal_name" {
  type = string
}
variable "env" {}

variable "service_principal_role_assignment" {}

variable "soft_delete_retention_days" {}

variable "key_vault_sku_name" {}

variable "cluster_name" {}
variable "default_node_pool_name" {}
variable "dns_prefix" {}
variable "vm_size" {}

variable "address_prefixes" {

}

//variable "subnet_id_foraks" {}