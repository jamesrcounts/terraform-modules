module "example" {
  source = "../"

  eventhub_connection_string = azurerm_eventhub_authorization_rule.wo.primary_connection_string
  eventhub_name              = local.evh_name
  eventhub_namespace_name    = local.evhns_name
}

resource "azurerm_eventhub_authorization_rule" "wo" {
  name                = "rw"
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  eventhub_name       = azurerm_eventhub.evh.name
  resource_group_name = azurerm_resource_group.main.name
  listen              = false
  send                = true
  manage              = false
}

resource "azurerm_eventhub" "evh" {
  name                = local.evh_name
  namespace_name      = azurerm_eventhub_namespace.evhns.name
  resource_group_name = azurerm_resource_group.main.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_namespace" "evhns" {
  name                = local.evhns_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard"
  capacity            = 1

  tags = local.tags
}

resource "azurerm_resource_group" "main" {
  name     = "rg-backend-${local.instance_id}"
  location = "centralus"
  tags = {
    "instance_id" = local.instance_id
  }
}

resource "random_pet" "instance_id" {}

locals {
  evh_name    = "evh-${local.instance_id}"
  evhns_name  = "evhns-${local.instance_id}"
  instance_id = random_pet.instance_id.id
  tags        = azurerm_resource_group.main.tags
}