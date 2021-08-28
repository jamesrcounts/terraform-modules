terraform {
  required_version = ">= 1"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2"
    }
  }
}

resource "azurerm_resource_group" "example" {
  location = "centralus"
  name     = "rg-example"
  tags = {
    instance_id = "test"
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

resource "azurerm_virtual_network" "vnet" {
  address_space       = ["10.0.0.0/8"]
  location            = azurerm_resource_group.example.location
  name                = "vnet-example"
  resource_group_name = azurerm_resource_group.example.name
  tags                = azurerm_resource_group.example.tags
}

resource "azurerm_subnet" "subnet" {

  address_prefixes     = [cidrsubnet(azurerm_virtual_network.vnet.address_space.0, 8, 3)]
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

module "aks" {
  source = "../"

  log_analytics_workspace = azurerm_log_analytics_workspace.insights
  resource_group          = azurerm_resource_group.example
  subnet                  = azurerm_subnet.subnet
  environment             = "example"
}