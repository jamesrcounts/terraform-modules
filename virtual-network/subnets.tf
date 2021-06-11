resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  address_prefixes     = [cidrsubnet(azurerm_virtual_network.vnet.address_space.0, each.value.0, each.value.1)]
  name                 = each.key
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}