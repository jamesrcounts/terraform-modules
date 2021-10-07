resource "azurerm_kubernetes_cluster" "example" {
  name                = "aks-${local.instance_id}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "aks-${local.instance_id}"
  kubernetes_version = data.azurerm_kubernetes_service_versions.current.latest_version

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = azurerm_resource_group.main.tags
}

data "azurerm_kubernetes_service_versions" "current" {
  location = azurerm_resource_group.main.location
}

resource "azurerm_resource_group" "main" {
  name     = "rg-backend-${local.instance_id}"
  location = "centralus"
  tags = {
    "instance_id" = local.instance_id
    "project" = "fluent-bit-module"
  }
}

resource "random_pet" "instance_id" {}

locals {
    instance_id = random_pet.instance_id.id
}

provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
          source = "hashicorp/azurerm"
          version = "2.78.0"
      }
  } 
}