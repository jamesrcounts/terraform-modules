data "azurerm_key_vault_secret" "values" {
  for_each = toset(var.additional_imports)

  name         = each.key
  key_vault_id = data.azurerm_key_vault.config.id
}