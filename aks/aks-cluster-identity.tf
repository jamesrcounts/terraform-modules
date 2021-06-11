resource "azurerm_user_assigned_identity" "aks" {
  location            = var.resource_group.location
  name                = "uai-${local.aks_cluster_name}"
  resource_group_name = var.resource_group.name
  tags                = var.resource_group.tags
}