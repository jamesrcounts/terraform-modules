resource "azurerm_virtual_network" "vnet" {
  address_space       = ["10.0.0.0/8"]
  location            = var.resource_group.location
  name                = "vnet-${local.environment_id}"
  resource_group_name = var.resource_group.name
  tags                = var.resource_group.tags
}