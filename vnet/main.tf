resource "azurerm_virtual_network" "myvnet" {
  name                = var.vnet_name
  resource_group_name =  var.rsg_name
  location            = var.rsg_location
  address_space       = var.vnet_cidr
  //tags                = local.tags
}

resource "azurerm_subnet" "mysubnet" {
  count                = length(var.address_prefixes)
  name                 = var.subnet_name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  resource_group_name  = var.rsg_name
  address_prefixes     = element([var.address_prefixes],count.index)
}
output "first_subnet_id" {
  value = azurerm_subnet.mysubnet[0].id
}