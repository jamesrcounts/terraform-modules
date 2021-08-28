data "azurerm_resource_group" "backend" {
  name = "rg-backend-${local.backend_instance_id}"
}

resource "azurerm_role_assignment" "keyvault_secrets_user" {
  for_each = {
    apim = azurerm_api_management.internal.identity.0.principal_id
  }

  principal_id         = each.value
  role_definition_name = "Key Vault Secrets User"
  scope                = data.azurerm_resource_group.backend.id
}