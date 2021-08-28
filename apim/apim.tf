resource "azurerm_api_management" "internal" {
  location             = var.resource_group.location
  name                 = local.apim_resource_name
  publisher_email      = "admin@contoso.com"
  publisher_name       = "Contoso"
  resource_group_name  = var.resource_group.name
  sku_name             = "Developer_1"
  virtual_network_type = "Internal"
  tags                 = var.resource_group.tags

  identity {
    type = "SystemAssigned"
  }

  virtual_network_configuration {
    subnet_id = var.subnet.id
  }
}

resource "azurerm_api_management_custom_domain" "domain" {
  depends_on = [
    azurerm_role_assignment.keyvault_secrets_user
  ]

  api_management_id = azurerm_api_management.internal.id

  proxy {
    host_name    = var.domains.gateway.host_name
    key_vault_id = var.domains.gateway.secret_id
  }

  developer_portal {
    host_name    = var.domains.portal.host_name
    key_vault_id = var.domains.portal.secret_id
  }
}
