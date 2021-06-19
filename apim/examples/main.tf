terraform {
  required_version = ">= 1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2"
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  location = "centralus"
  name     = "rg-example"
  tags = {
    instance_id = "test"
  }
}

resource "azurerm_virtual_network" "vnet" {
  address_space       = ["10.0.0.0/8"]
  location            = azurerm_resource_group.example.location
  name                = "vnet-example"
  resource_group_name = azurerm_resource_group.example.name
  tags                = azurerm_resource_group.example.tags
}

resource "azurerm_subnet" "subnet" {

  address_prefixes     = [cidrsubnet(azurerm_virtual_network.vnet.address_space.0, 8, 3)]
  name                 = "apim-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}


resource "azurerm_key_vault" "config" {
  enable_rbac_authorization   = true
  enabled_for_disk_encryption = true
  location                    = azurerm_resource_group.example.location
  name                        = "kv-example"
  purge_protection_enabled    = true
  resource_group_name         = azurerm_resource_group.example.name
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  tags                        = azurerm_resource_group.example.tags
  tenant_id                   = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_key_vault_certificate" "apim" {
  for_each = {
    gateway = "gateway.example.com"
    portal  = "portal.example.com"
  }

  name         = replace(each.value.hostname, ".", "-")
  key_vault_id = azurerm_key_vault.config.id
  tags         = azurerm_resource_group.example.tags

  certificate_policy {
    issuer_parameters {
      name = "Unknown"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = false
    }

    lifetime_action {
      action {
        action_type = "EmailContacts"
      }

      trigger {
        lifetime_percentage = 50
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }
  }
}

resource "azurerm_log_analytics_workspace" "insights" {
  name                = "la-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = azurerm_resource_group.example.tags
}

module "apim" {
  source = "../"

  log_analytics_workspace = azurerm_log_analytics_workspace.insights
  resource_group          = azurerm_resource_group.example
  subnet                  = azurerm_subnet.subnet

  domains = {
    portal = {
      host_name = "portal.jamesrcounts.com"
      secret_id = azurerm_key_vault_certificate.apim["portal"].secret_id
    }
    gateway = {
      host_name = "api.jamesrcounts.com"
      secret_id = azurerm_key_vault_certificate.apim["gateway"].secret_id
    }
  }
}
