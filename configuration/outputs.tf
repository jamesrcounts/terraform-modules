output "imports" {
  value = { for k, v in data.azurerm_key_vault_secret.values : k => v.value }
}

output "instance_id" {
  value = data.azurerm_resource_group.backend.tags["instance_id"]
}

output "key_vault" {
  value = {
    id        = data.azurerm_key_vault.config.id
    name      = data.azurerm_key_vault.config.name
    tenant_id = data.azurerm_key_vault.config.tenant_id
  }
}

output "log_analytics_workspace" {
  value = data.azurerm_log_analytics_workspace.main
}