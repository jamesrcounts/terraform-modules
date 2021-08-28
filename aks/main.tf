locals {
  aks_cluster_name = "aks-${local.environment_id}"
  aks_node_labels  = { for k, v in var.resource_group.tags : k => replace(v, "/", ".") }
  environment_id   = "${local.instance_id}-${var.environment}"
  instance_id      = var.resource_group.tags["instance_id"]
}

