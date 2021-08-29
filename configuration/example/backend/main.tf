locals {
  instance_id = random_pet.instance_id.id
  tags        = azurerm_resource_group.backend.tags
}

resource "random_pet" "instance_id" {}

resource "azurerm_resource_group" "backend" {
  name     = "rg-backend-${local.instance_id}"
  location = "centralus"
  tags = {
    "instance_id" = local.instance_id
  }
}

resource "azurerm_log_analytics_workspace" "diagnostics" {
  name                = "la-${local.instance_id}"
  location            = azurerm_resource_group.backend.location
  resource_group_name = azurerm_resource_group.backend.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.tags
}

resource "azurerm_key_vault" "config" {
  enable_rbac_authorization   = true
  enabled_for_disk_encryption = false
  location                    = azurerm_resource_group.backend.location
  name                        = "kv-${local.instance_id}"
  purge_protection_enabled    = false
  resource_group_name         = azurerm_resource_group.backend.name
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  tags                        = local.tags
  tenant_id                   = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_key_vault_secret" "exports" {
  for_each = {
    subnets = jsonencode({
      a = "b"
    })
  }

  key_vault_id = azurerm_key_vault.config.id
  name         = each.key
  value        = each.value
}

data "azurerm_client_config" "current" {}

provider "azurerm" {
  features {}
}