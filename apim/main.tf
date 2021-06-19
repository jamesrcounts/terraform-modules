locals {
  instance_id        = var.resource_group.tags["instance_id"]
  apim_resource_name = "apim-${local.instance_id}"
}