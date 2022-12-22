data "azurerm_kubernetes_service_versions" "version" {
    location = var.rsg_location
}
output "latest_version" {
  value = data.azurerm_kubernetes_service_versions.version.latest_version
}
resource "azurerm_kubernetes_cluster" "k8scluster" {
  name                = var.cluster_name
  location            = var.rsg_location
  resource_group_name = var.rsg_name
  kubernetes_version  = var.kubernetes_version
  sku_tier            = var.sku_tier
  dns_prefix = var.dns_prefix
  linux_profile {
    admin_username = "satya"
    ssh_key {
      key_data = var.ssh_pubkey
    }
  }
  default_node_pool {
    name           = var.default_node_pool_name
    node_count     = 2
    vm_size        = var.vm_size
    type           = "VirtualMachineScaleSets"
    vnet_subnet_id = var.vnet_subnet_id
  }
   network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
  service_principal {
    client_id = var.client_id
    client_secret = var.client_secret
  } 
  
}
output "client_certificate" {
  value     = azurerm_kubernetes_cluster.k8scluster.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8scluster.kube_config_raw

  sensitive = true
}


