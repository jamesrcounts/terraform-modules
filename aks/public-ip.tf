resource "azurerm_public_ip_prefix" "pib" {
  location            = var.resource_group.location
  name                = "pib-${local.environment_id}"
  prefix_length       = 31
  resource_group_name = var.resource_group.name
  sku                 = "Standard"
  tags                = var.resource_group.tags
}

resource "azurerm_public_ip" "aks" {
  allocation_method   = "Static"
  domain_name_label   = local.environment_id
  location            = var.resource_group.location
  name                = "pip-${local.environment_id}"
  public_ip_prefix_id = azurerm_public_ip_prefix.pib.id
  resource_group_name = var.resource_group.name
  sku                 = "Standard"
  tags                = var.resource_group.tags
}