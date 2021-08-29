data "azurerm_log_analytics_workspace" "main" {
  name                = "la-${local.instance_id}"
  resource_group_name = data.azurerm_resource_group.backend.name
}