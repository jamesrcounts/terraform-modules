resource "azurerm_log_analytics_solution" "insights" {
  solution_name         = "ContainerInsights"
  location              = var.resource_group.location
  resource_group_name   = var.resource_group.name
  workspace_resource_id = var.log_analytics_workspace.id
  workspace_name        = var.log_analytics_workspace.name
  tags                  = var.resource_group.tags

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}