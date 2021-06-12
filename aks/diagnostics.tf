module "diagnostics" {
  source = "github.com/jamesrcounts/terraform-modules.git//diagnostics?ref=aks"

  log_analytics_workspace_id = var.log_analytics_workspace.id

  monitored_services = {
    aks = azurerm_kubernetes_cluster.aks.id
  }
}