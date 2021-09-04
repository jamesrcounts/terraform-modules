resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  address_prefixes                               = [cidrsubnet(azurerm_virtual_network.vnet.address_space.0, each.value.bits, each.value.net)]
  enforce_private_link_endpoint_network_policies = each.value.enable_private_endpoint
  name                                           = each.key
  resource_group_name                            = var.resource_group.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
}