variable "rsg_name" {}
variable "rsg_location" {}
variable "cluster_name" {}
variable "default_node_pool_name" {}
variable "dns_prefix" {}
variable "vm_size" {}
variable "kubernetes_version" {
}
variable "sku_tier" {}
output "kubernetes_version" {
  value = data.azurerm_kubernetes_service_versions.version.latest_version
}

variable "client_secret" {}

variable "client_id" {
  
}

variable "vnet_subnet_id" {}
variable "ssh_pubkey" {
  
}