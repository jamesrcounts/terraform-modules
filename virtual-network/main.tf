locals {
  environment_id = "${local.instance_id}-${var.environment}"
  instance_id    = var.resource_group.tags["instance_id"]
}